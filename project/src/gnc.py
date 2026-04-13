import numpy as np
from .registration import registrationHorn


def registrationGnc(
    pcd1,
    pcd2,
    robust_func="tls",
    threshold_c=1.0,
    max_iter=1000,
    tol=1e-6,
    gnc_factor=1.4,
):
    """
    Solves robust point cloud registration using Graduated Non-Convexity (GNC).

    Arguments
    - `pcd1`        - Source point cloud.
    - `pcd2`        - Target point cloud.
    - `robust_func` - "tls" or "l1".
    - `threshold_c` - Outlier rejection threshold.
    - `max_iter`    - Maximum number of iterations.
    - `tol`         - Cost tolerance for early stop.
    - `gnc_factor`  - Surrogate parameter's update step size.

    Returns

    - `rot` - Rotation matrix.
    - `t`   - Translation vector.
    """

    def get_residuals(r_mat, t_vec):
        pcd1_transformed = pcd1 @ r_mat.T + t_vec
        diff = pcd2 - pcd1_transformed
        return np.linalg.norm(diff, axis=1)

    rot, t = registrationHorn(pcd1, pcd2)

    res = get_residuals(rot, t)
    prev_cost = np.sum(res * res)

    sq_c = threshold_c * threshold_c
    max_sq_res = np.max(res * res)

    if robust_func == "tls":
        mu = sq_c / (2 * max_sq_res - sq_c)
        if 0 <= mu < 1e-6:
            mu = 1e-6
    elif robust_func == "l1":
        mu = 1.0
    else:
        raise ValueError(f"Unknown robust function: {robust_func}")

    if robust_func == "l1" and gnc_factor > 1.0:
        gnc_factor = 1.0 / gnc_factor

    for i in range(max_iter):
        sq_res = res * res
        weights = np.zeros(len(res))

        if robust_func == "tls":
            th2 = ((mu + 1) / mu) ** 2 * sq_c
            
            weights[sq_res <= sq_c] = 1.0
            
            mask = (sq_res > sq_c) & (sq_res <= th2)
            weights[mask] = (threshold_c / res[mask]) * (mu + 1) - mu

        elif robust_func == "l1":
            weights = 1.0 / np.maximum(res, mu)

        rot, t = registrationHorn(pcd1, pcd2, weight=weights)
        res = get_residuals(rot, t)

        curr_cost = np.sum(res * res)
        cost_converged = abs(curr_cost - prev_cost) / max(prev_cost, 1e-7) < tol

        weight_converged = False
        if robust_func == "tls":
            weight_converged = np.all(
                np.isclose(weights, 0.0) | np.isclose(weights, 1.0)
            )

        if cost_converged or weight_converged:
            break

        prev_cost = curr_cost

        if robust_func == "tls":
            if mu < 1.0:
                mu = np.sqrt(mu)
            mu *= gnc_factor
            
        elif robust_func == "l1":
            mu = max(gnc_factor * mu, threshold_c)

    return rot, t
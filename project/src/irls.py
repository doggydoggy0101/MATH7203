import numpy as np
from .registration import registrationHorn


def registrationIrls(
    pcd1, pcd2, robust_func="tls", threshold_c=1.0, max_iter=1000, tol=1e-6
):
    """
    Solves robust point cloud registration using Iteratively Reweighted Least Squares.

    Arguments
    - `pcd1`        - Source point cloud.
    - `pcd2`        - Target point cloud.
    - `robust_func` - "l1" or "tls".
    - `threshold_c` - Outlier rejection threshold.
    - `max_iter`    - Maximum number of iterations.
    - `tol`         - Cost tolerance for early stop.

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
    weights = np.ones(len(pcd1))

    for i in range(max_iter):
        # 2. Compute weights based on the robust function
        if robust_func == "l1":
            weights = 1.0 / np.maximum(res, 1e-6)
        elif robust_func == "tls":
            weights = np.where(res * res <= threshold_c * threshold_c, 1.0, 0.0)
            if np.sum(weights) == 0:
                break
        else:
            raise ValueError(f"Unknown robust function: {robust_func}")

        rot, t = registrationHorn(pcd1, pcd2, weight=weights)
        res = get_residuals(rot, t)

        # stopping criteria
        curr_cost = np.sum(res * res)
        if abs(curr_cost - prev_cost) / max(prev_cost, 1e-7) < tol:
            break

        prev_cost = curr_cost

    return rot, t

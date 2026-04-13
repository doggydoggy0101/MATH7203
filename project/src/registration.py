import numpy as np


def get_zero_mean_point_cloud(pcd, weight=None):
    """
    Gets the zero mean point cloud.

    Arguments

    - `pcd`    - Input point cloud.
    - `weight` - Weights for each point (optional).

    Returns

    - `zm_pcd` - Point cloud with zero mean.
    - `mean`   - Mean of the original point cloud.
    """
    if weight is None:
        mean = np.mean(pcd, axis=0)
    else:
        mean = np.sum(pcd * weight[:, None], axis=0) / np.sum(weight)

    zm_pcd = pcd - mean

    return zm_pcd, mean


def project(mat):
    """
    Closed-form solution for the Orthogonal Procrustes problem.
    This function finds the nearest rotation of a given matrix.

    Arguments

    - `mat` - Input matrix.

    Returns

    - `rot` - Rotation matrix.
    """
    U, _, Vt = np.linalg.svd(mat)
    rot = U @ Vt

    # reflection case
    if np.linalg.det(rot) < 0:
        D = np.diag(np.array([1.0, 1.0, -1.0]))
        rot = U @ D @ Vt

    return rot


def registrationHorn(pcd1, pcd2, weight=None):
    """
    Closed-form solution for registration by Horn.

    Arguments

    - `pcd1`   - Source point cloud.
    - `pcd2`   - Target point cloud.
    - `weight` - Weights for each point (optional).

    Returns

    - `rot` - Rotation matrix.
    - `t`   - Translation vector.
    """
    zmpcd1, mean1 = get_zero_mean_point_cloud(pcd1)
    zmpcd2, mean2 = get_zero_mean_point_cloud(pcd2)

    if weight is None:
        M = zmpcd2.T @ zmpcd1
    else:
        M = (zmpcd2 * weight[:, None]).T @ zmpcd1

    rot = project(M)

    t = mean2 - rot @ mean1

    return rot, t

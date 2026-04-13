import copy
import numpy as np
import open3d as o3d


def get_bunny_data(
    num_point,
    rotation,
    translation,
    noise_std=0.01,
    outlier_ratio=0.0,
    outlier_scale=10.0,
    random_state=42,
):
    np.random.seed(random_state)

    se3 = np.eye(4)
    se3[:3, :3] = rotation
    se3[:3, 3] = translation

    # create bunny
    dataset = o3d.data.BunnyMesh()
    mesh = o3d.io.read_triangle_mesh(dataset.path)
    o3d.utility.random.seed(random_state)
    pcd1o3d = mesh.sample_points_poisson_disk(number_of_points=num_point)
    pcd1o3d.scale(
        1 / np.max(pcd1o3d.get_max_bound() - pcd1o3d.get_min_bound()),
        center=pcd1o3d.get_center(),
    )  # normalize
    pcd1o3d.translate(-pcd1o3d.get_center())  # align center to (0,0,0)

    # apply noise
    pcd2o3d = copy.deepcopy(pcd1o3d)
    pcd_temp = np.asarray(pcd2o3d.points)
    pcd_temp += np.random.normal(0, noise_std, size=pcd_temp.shape)
    pcd2o3d.points = o3d.utility.Vector3dVector(pcd_temp)

    # apply transformation
    pcd2o3d.rotate(rotation)
    pcd2o3d.translate(translation)

    pcd1 = np.asarray(pcd1o3d.points)
    pcd2 = np.asarray(pcd2o3d.points)

    # apply outliers
    if outlier_ratio > 0.0:
        num_outliers = int(num_point * outlier_ratio)
        outlier_indices = np.random.choice(num_point, num_outliers, replace=False)

        min_bound = np.min(pcd2, axis=0)
        max_bound = np.max(pcd2, axis=0)

        center = (max_bound + min_bound) / 2.0
        extent = (max_bound - min_bound) * outlier_scale

        random_points = np.random.uniform(
            low=center - (extent / 2.0),
            high=center + (extent / 2.0),
            size=(num_outliers, 3),
        ) 

        pcd2[outlier_indices] = random_points

    return pcd1, pcd2, se3


def get_3dmatch_data(load_correspondence=True):
    # NOTE [target, source]
    if load_correspondence:
        src = np.loadtxt("assets/3dmatch/cloud_bin_10.txt")
        dst = np.loadtxt("assets/3dmatch/cloud_bin_0.txt")
    else:
        src_o3d = o3d.io.read_point_cloud("assets/3dmatch/cloud_bin_10.ply")
        dst_o3d = o3d.io.read_point_cloud("assets/3dmatch/cloud_bin_0.ply")
        src = np.asarray(src_o3d.points)
        dst = np.asarray(dst_o3d.points)

    gt = np.loadtxt("assets/3dmatch/gt.txt")
    return src, dst, gt

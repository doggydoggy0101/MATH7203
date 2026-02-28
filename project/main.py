import numpy as np
import open3d as o3d
from scipy.spatial.transform import Rotation as R

from solver import registrationHorn
from data import get_bunny_data, get_3dmatch_data


def print_solution(rot, t):
    sol = np.eye(4)
    sol[:3, :3] = rot
    sol[:3, 3] = t
    print(sol, end="\n\n")


def add_pcd(scene, name, array, color, size):
    pcd = o3d.geometry.PointCloud()
    pcd.points = o3d.utility.Vector3dVector(array)
    pcd.paint_uniform_color(color)

    mat = o3d.visualization.rendering.MaterialRecord()
    mat.shader = "defaultLit"
    mat.point_size = size
    scene.add_geometry(name, pcd, mat)


def add_line(scene, name, pcd1, pcd2, color):
    points = np.vstack((pcd1, pcd2))
    lines = [[i, i + len(pcd1)] for i in range(len(pcd1))]

    line_set = o3d.geometry.LineSet()
    line_set.points = o3d.utility.Vector3dVector(points)
    line_set.lines = o3d.utility.Vector2iVector(lines)
    line_set.colors = o3d.utility.Vector3dVector([color for _ in lines])

    mat = o3d.visualization.rendering.MaterialRecord()
    mat.shader = "defaultLit"
    scene.add_geometry(name, line_set, mat)


def draw(pcd1, pcd2, base1, base2, data="bunny", line=True):
    app = o3d.visualization.gui.Application.instance
    app.initialize()
    window = app.create_window("Open3d", 1024, 768)
    widget3d = o3d.visualization.gui.SceneWidget()
    widget3d.scene = o3d.visualization.rendering.Open3DScene(window.renderer)
    widget3d.scene.set_background([1.0, 1.0, 1.0, 255.0])  # white
    window.add_child(widget3d)

    if data == "3dmatch":
        add_pcd(widget3d.scene, "pcd1", pcd1, [0.0, 0.0, 1.0], 5)
        add_pcd(widget3d.scene, "pcd2", pcd2, [1.0, 0.0, 0.0], 5)

        if line:
            add_line(widget3d.scene, "correspondences", pcd1, pcd2, [0, 1, 0])

        add_pcd(widget3d.scene, "base1", base1, [0.4, 0.4, 1], 2)
        add_pcd(widget3d.scene, "base2", base2, [1, 0.4, 0.4], 2)

        widget3d.setup_camera(60, widget3d.scene.bounding_box, [0, 0, 0])

    elif data == "bunny":
        add_pcd(widget3d.scene, "pcd1", pcd1, [0.0, 0.0, 1.0], 10)
        add_pcd(widget3d.scene, "pcd2", pcd2, [1.0, 0.0, 0.0], 10)

        if line:
            add_line(widget3d.scene, "correspondences", pcd1, pcd2, [0, 1, 0])

        add_pcd(widget3d.scene, "base1", base1, [0.4, 0.4, 1], 5)
        add_pcd(widget3d.scene, "base2", base2, [1, 0.4, 0.4], 5)

        widget3d.setup_camera(60, widget3d.scene.bounding_box, [0, 0, 0])
        widget3d.look_at(
            [0.10370103683525639, 0.27598735918010331, 0.27164549493084322],
            [1.6, 3.2, 1],
            [-0.52887297014461898, -0.10017470192752206, 0.8427683018150014],
        )

    app.run()


visualize = True
data = "bunny"

if data == "3dmatch":
    src_reg, dst_reg, gt_reg = get_3dmatch_data()
if data == "bunny":
    rng = 134
    translation = np.random.RandomState(rng).rand(3) / np.sqrt(3)
    rotation = R.random(random_state=rng).as_matrix()
    src_reg, dst_reg, gt_reg = get_bunny_data(
        num_point=100,
        rotation=rotation,
        translation=translation,
        noise_std=10.01,
        random_state=rng,
    )

print("Ground truth:")
print(gt_reg, end="\n\n")


if visualize:
    if data == "3dmatch":
        src_base, dst_base, _ = get_3dmatch_data(load_correspondence=False)
    if data == "bunny":
        src_base, dst_base, _ = get_bunny_data(
            num_point=2500,
            rotation=rotation,
            translation=translation,
            random_state=rng,
        )
    draw(pcd1=src_reg, pcd2=dst_reg, base1=src_base, base2=dst_base, data=data)


rot, t = registrationHorn(src_reg, dst_reg)
print_solution(rot, t)


if visualize:
    draw(
        pcd1=(rot @ src_reg.T).T + t,
        pcd2=dst_reg,
        base1=(rot @ src_base.T).T + t,
        base2=dst_base,
        data=data,
        line=False,
    )
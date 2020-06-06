import numpy as np
from matplotlib.path import Path
from matplotlib.patches import PathPatch

def plot(ax, maze, entrances=False, solutions=False):
    """ Generate an line-drawn image of the maze. """
    grid = maze.grid.T

    H = len(grid)
    W = len(grid[0])
    h = (H - 1) // 2
    w = (W - 1) // 2

    vertices = []
    codes = []

    # loop over horizontals
    for r,rr in enumerate(range(1, H, 2)):
        run = []
        for c,cc in enumerate(range(1, W, 2)):
            if grid[rr-1,cc]:
                if not run:
                    run = [(r,c)]
                run += [(r,c+1)]
            else:
                _use_run(codes, vertices, run)
                run = []
        _use_run(codes, vertices, run)

    # grab bottom side of last row
    run = []
    for c,cc in enumerate(range(1, W, 2)):
        if grid[H-1,cc]:
            if not run:
                run = [(H//2,c)]
            run += [(H//2,c+1)]
        else:
            _use_run(codes, vertices, run)
            run = []
        _use_run(codes, vertices, run)

    # loop over verticles
    for c,cc in enumerate(range(1, W, 2)):
        run = []
        for r,rr in enumerate(range(1, H, 2)):
            if grid[rr,cc-1]:
                if not run:
                    run = [(r,c)]
                run += [(r+1,c)]
            else:
                _use_run(codes, vertices, run)
                run = []
        _use_run(codes, vertices, run)

    # grab far right column
    run = []
    for r,rr in enumerate(range(1, H, 2)):
        if grid[rr,W-1]:
            if not run:
                run = [(r,W//2)]
            run += [(r+1,W//2)]
        else:
            _use_run(codes, vertices, run)
            run = []
        _use_run(codes, vertices, run)

    vertices = np.array(vertices, float)
    path = Path(vertices, codes)

    # for a line maze
    pathpatch = PathPatch(path, facecolor='None', edgecolor='black', lw=2)
    ax.add_patch(pathpatch)

    # hide axis and labels
    ax.axis('off')
    ax.dataLim.update_from_data_xy([(-0.1,-0.1), (h + 0.1, w + 0.1)])
    ax.autoscale_view()

    if entrances and maze.start and maze.end:
        sx = np.array([-1,-1,1,1,-1]) / 4
        sy = np.array([-1,1,1,-1,-1]) / 4
        ax.plot(maze.start[1]/2 + sx, maze.start[0]/2 + sy)
        ax.plot(maze.end[1]/2 + sx, maze.end[0]/2 + sy)

    if solutions and maze.solutions:
        sxy = np.array(maze.solutions[0]) / 2
        ax.plot(sxy[:,1], sxy[:,0])

def _use_run(codes, vertices, run):
    if run:
        codes += [Path.MOVETO] + [Path.LINETO] * (len(run) - 1)
        vertices += run


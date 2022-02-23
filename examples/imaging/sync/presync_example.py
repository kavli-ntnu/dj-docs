"""
Code snippet to generate the image `docs/_static/imaging/sync/presync-example.png`
"""

import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

planes = 3
t0 = 2000
t1 = 7000
volume_time = 1200

sns.set_theme()

def pwm(t, period, percentage, invert=False):
    out = []
    for i in t:
        value = int(((i%period) / period) < percentage)
        out.append(value)
    out = np.array(out)
    if invert:
        out = np.logical_not(out)
    return out



time = np.arange(t0, t1, 1)

# volume line
volume_y = pwm(time, volume_time, 0.9, )
plane_y = pwm(time, volume_time/planes, 0.4)
tracking_y = pwm(time, volume_time/planes, 0.08, invert=True)

volume_y[:300] = 0
plane_y[:360] = 0
tracking_y[:300] = 1


dpi = 96
fig, ax = plt.subplots(nrows=3, ncols=1, figsize=(2100/dpi, 700/dpi), sharey=True, sharex=True)

# Plot pwm outline
sns.lineplot(x=time, y=volume_y, ax=ax[0])
sns.lineplot(x=time, y=plane_y, ax=ax[1])
sns.lineplot(x=time, y=tracking_y, ax=ax[2])

# plot on markers
## planes
for (axis, y, pol) in zip(ax, (volume_y, plane_y, plane_y), (1, 1, 1)):
    tx = time[np.where(np.diff(y) == pol)]
    for x in tx:
        axis.plot((x,x), (-1, 1), linewidth=1, color="g", linestyle="--")



ax[0].set_xlim(2000, 7000)
ax[0].set_ylim(-1.1, 1.1)
ax[0].yaxis.set_ticks((-1, 0, 1))
ax[0].set_title("2P Volumes")
ax[1].set_title("2P Planes")
ax[2].set_title("Tracking frames")

fig.savefig(r"..\..\..\docs\_static\imaging\sync\presync_example.png", dpi=dpi)
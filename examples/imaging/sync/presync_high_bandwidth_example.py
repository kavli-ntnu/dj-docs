"""
Code snippet to generate the image `docs/_static/imaging/sync/presync_high_bandwidth_example-example.png`
"""

import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib.cm as cm

planes = 3
t0 = 2000
t1 = 4000
volume_time = 1200
hbw_per = 27
size = 48

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



time = np.arange(t0, t1, 0.2)
volume_y = pwm(time, volume_time, 0.9, )
plane_y = pwm(time, volume_time/planes, 0.8)
hbw = pwm(time, hbw_per, 0.2)
volume_y[:1500] = 0
plane_y[:1600] = 0

frame_data = np.random.random_sample((size, size))
hbw_data = np.arange(size*size, dtype=float)
hbw_data *= np.random.random_sample(hbw_data.shape)
missing = np.random.random_sample(hbw_data.shape) < 0.6
hbw_data[missing] = np.nan
hbw_data = hbw_data.reshape((size,size))




dpi = 96
fig = plt.figure(figsize=(1200/dpi, 1000/dpi), tight_layout=True)
gs = gridspec.GridSpec(nrows=5, ncols=4)
ax = (
      fig.add_subplot(gs[0,:]),         # volumes
      fig.add_subplot(gs[1,:]),         # planes
      fig.add_subplot(gs[2,:]),         # high_bandwidth
      fig.add_subplot(gs[3:, :2]),      # 2p imaging
      fig.add_subplot(gs[3:, 2:]),      # high bandwidth
      )

sns.lineplot(x=time, y=volume_y, ax=ax[0])
sns.lineplot(x=time, y=plane_y, ax=ax[1])
sns.lineplot(x=time, y=hbw, ax=ax[2])

ax[2].fill_between(time, plane_y*1.05, alpha=0.2)

sns.heatmap(frame_data, ax=ax[3], cbar=False, yticklabels=False, xticklabels=False)
sns.heatmap(hbw_data, ax=ax[4], cbar=False, cmap=cm.jet, yticklabels=False, xticklabels=False)



for i in range(3):
    ax[i].set_xlim(2200, 4000)
    ax[i].set_ylim(-0.1, 1.1)
    ax[i].yaxis.set_ticks((0, 1))
    ax[i].xaxis.set_ticks(())
ax[2].xaxis.set_ticks((2500, 3000, 3500, 4000))

for i in range(3,5):
    ax[i].tick_params(left=False, bottom=False)
ax[0].set_title("2P Volumes")
ax[1].set_title("2P Planes")
ax[2].set_title("High bandwidth instrument")

ax[3].set_title("2P imaging frame data")
ax[4].set_title("High bandwidth instrument data")

plt.show()
fig.savefig(r"..\..\..\docs\_static\imaging\sync\presync_high_bandwidth_example.png", dpi=dpi)
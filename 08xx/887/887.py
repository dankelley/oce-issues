from dolfyn.adv import api as adv
xyz = adv.read_nortek("/Users/kelley/src/dolfyn/example_data/vector_data_imu01.VEC")
print xyz.u
print xyz.v
print xyz.w

# NB. python is not functional!
# NB. I don't think this is the right function...
enu = xyz
adv.rotate.inst2earth(enu)
print enu.u
print enu.v
print enu.w

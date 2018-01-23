Velodyne 3D laser scan data
http://www.cvlibs.net/datasets/kitti/raw_data.php?type=calibration
================================================
...the velodyne point clouds are stored in the folder 'velodyne_points'. To
save space, all scans have been stored as Nx4 float matrix into a binary
file using the following code:

  stream = fopen (dst_file.c_str(),"wb");
  fwrite(data,sizeof(float),4*num,stream);
  fclose(stream);

Here, data contains 4*num values, where the first 3 values correspond to
x,y and z, and the last value is the reflectance information. All scans
are stored row-aligned, meaning that the first 4 values correspond to the
first measurement. Since each scan might potentially have a different
number of points, this must be determined from the file size when reading
the file, where 1e6 is a good enough upper bound on the number of values:

  // allocate 4 MB buffer (only ~130*4*4 KB are needed)
  int32_t num = 1000000;
  float *data = (float*)malloc(num*sizeof(float));

  // pointers
  float *px = data+0;
  float *py = data+1;
  float *pz = data+2;
  float *pr = data+3;

  // load point cloud
  FILE *stream;
  stream = fopen (currFilenameBinary.c_str(),"rb");
  num = fread(data,sizeof(float),num,stream)/4;
  for (int32_t i=0; i<num; i++) {
    point_cloud.points.push_back(tPoint(*px,*py,*pz,*pr));
    px+=4; py+=4; pz+=4; pr+=4;
  }
  fclose(stream);


Coordinate Systems
==================
...x, y and z are stored in metric (m) Velodyne coordinates.

The coordinate systems are defined the following way, where directions
are informally given from the drivers view, when looking forward onto
the road:

x: forward, y: left,  z: up

All coordinate systems are right-handed.


IMPORTANT NOTE: Note that the velodyne scanner takes depth measurements
continuously while rotating around its vertical axis (in contrast to the cameras,
which are triggered at a certain point in time). This means that when computing
point clouds you have to 'untwist' the points linearly with respect to the velo-
dyne scanner location at the beginning and the end of the 360° sweep. The time-
stamps for the beginning and the end of the sweeps can be found in the time-
stamps file. The velodyne rotates in counter-clockwise direction.

Of course this 'untwisting' only works for non-dynamic environments.

The relationship between the camera triggers and the velodyne is the following:
We trigger the cameras when the velodyne is looking exactly forward (into the
direction of the cameras).




// Set the view and projection matrices
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);

// Apply the camera
camera_apply(camera);
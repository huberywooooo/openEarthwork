subroutine calc_grid(x_surface, y_surface, z_surface, n_surface, &
                    x_base, y_base, z_base, n_base, &
                    grid_size, &
                    grid_x, grid_y, grid_z_surface, grid_z_base, nx, ny)
    ! Create the grid and interpolate
    ! input:
    !   x_surface, y_surface, z_surface - surface point coordinates
    !   x_base, y_base, z_base         - base point coordinates
    !   n_surface, n_base              - number of points
    !   grid_size                      - size of grid cells
    ! output:
    !   grid_x, grid_y                 - grid coordinates
    !   grid_z_surface, grid_z_base    - interpolated elevation data
    !   nx, ny                         - grid dimensions
    !
    !   openExcav: An Open Source Library for Excavation Calculation
    !   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    !   Copyright 2009-2024 Chongqing Three Gorges University
    
    implicit none
    
    ! Arguments
    integer, intent(in) :: n_surface, n_base
    real, intent(in) :: x_surface(n_surface), y_surface(n_surface), z_surface(n_surface)
    real, intent(in) :: x_base(n_base), y_base(n_base), z_base(n_base)
    real, intent(in) :: grid_size
    real, allocatable, intent(out) :: grid_x(:,:), grid_y(:,:)
    real, allocatable, intent(out) :: grid_z_surface(:,:), grid_z_base(:,:)
    integer, intent(out) :: nx, ny
    
    ! Local variables
    real :: xmin, xmax, ymin, ymax
    integer :: i, j
    
    ! Determine calculation area boundary
    xmin = min(minval(x_surface), minval(x_base)) - grid_size
    xmax = max(maxval(x_surface), maxval(x_base)) + grid_size
    ymin = min(minval(y_surface), minval(y_base)) - grid_size
    ymax = max(maxval(y_surface), maxval(y_base)) + grid_size
    
    ! Calculate grid dimensions
    nx = ceiling((xmax - xmin) / grid_size) + 1
    ny = ceiling((ymax - ymin) / grid_size) + 1
    
    ! Allocate grid arrays
    allocate(grid_x(nx,ny), grid_y(nx,ny))
    allocate(grid_z_surface(nx,ny), grid_z_base(nx,ny))
    
    ! Create grid points (meshgrid equivalent)
    do j = 1, ny
        do i = 1, nx
            grid_x(i,j) = xmin + (i-1) * grid_size
            grid_y(i,j) = ymin + (j-1) * grid_size
        end do
    end do
    
    ! Interpolate surface and base
    call natural_interpolation(x_surface, y_surface, z_surface, n_surface, &
                             grid_x, grid_y, nx, ny, grid_z_surface)
    
    call natural_interpolation(x_base, y_base, z_base, n_base, &
                             grid_x, grid_y, nx, ny, grid_z_base)

end subroutine calc_grid

! Helper subroutine for natural neighbor interpolation
subroutine natural_interpolation(x, y, z, n_points, grid_x, grid_y, nx, ny, grid_z)
    implicit none
    integer, intent(in) :: n_points, nx, ny
    real, intent(in) :: x(n_points), y(n_points), z(n_points)
    real, intent(in) :: grid_x(nx,ny), grid_y(nx,ny)
    real, intent(out) :: grid_z(nx,ny)
    
    ! Note: This is a placeholder for the actual interpolation
    ! You'll need to implement or use an external library for natural neighbor interpolation
    ! For now, we'll use a simple inverse distance weighting as an example
    
    integer :: i, j, k
    real :: dist, weight, sum_weights
    
    do j = 1, ny
        do i = 1, nx
            sum_weights = 0.0
            grid_z(i,j) = 0.0
            
            do k = 1, n_points
                dist = sqrt((grid_x(i,j)-x(k))**2 + (grid_y(i,j)-y(k))**2)
                if (dist < 1.0e-10) then
                    grid_z(i,j) = z(k)
                    goto 100
                end if
                weight = 1.0 / dist**2
                grid_z(i,j) = grid_z(i,j) + weight * z(k)
                sum_weights = sum_weights + weight
            end do
            grid_z(i,j) = grid_z(i,j) / sum_weights
            100 continue
        end do
    end do
    
end subroutine natural_interpolation 
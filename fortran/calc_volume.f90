subroutine calc_volume(grid_x, grid_y, z_surface, z_base, nx, ny, &
    contour_x, contour_y, n_contour, grid_size, &
    exca_volume, fill_volume, grid_volume)
    ! Calculate the volume
    ! input:
    !   grid_x, grid_y   - grid coordinates
    !   z_surface, z_base - surface and base elevations
    !   nx, ny           - grid dimensions
    !   contour_x, contour_y - boundary points
    !   n_contour        - number of contour points
    !   grid_size        - size of grid cell
    ! output:
    !   exca_volume      - excavation volume
    !   fill_volume      - fill volume
    !   grid_volume      - net volume
    !
    !   openExcav: An Open Source Library for Excavation Calculation
    !   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    !   Copyright 2009-2024 Chongqing Three Gorges University
    
    implicit none
    
    ! Arguments
    integer, intent(in) :: nx, ny, n_contour
    real, intent(in) :: grid_x(nx,ny), grid_y(nx,ny)
    real, intent(in) :: z_surface(nx,ny), z_base(nx,ny)
    real, intent(in) :: contour_x(n_contour), contour_y(n_contour)
    real, intent(in) :: grid_size
    real, intent(out) :: exca_volume, fill_volume, grid_volume
    
    ! Local variables
    integer :: i, j
    real :: delta_z, grid_area, current_volume
    logical :: is_inside
    
    ! Initialize volumes
    exca_volume = 0.0
    fill_volume = 0.0
    grid_area = grid_size * grid_size
    
    ! Calculate volumes for each grid cell
    do i = 1, nx
        do j = 1, ny
            ! Check if grid point is inside boundary
            call check_point_in_polygon(grid_x(i,j), grid_y(i,j), &
                contour_x, contour_y, n_contour, is_inside)
            
            if (is_inside) then
                if (.not. isnan(z_surface(i,j)) .and. &
                    .not. isnan(z_base(i,j))) then
                    
                    delta_z = z_surface(i,j) - z_base(i,j)
                    current_volume = delta_z * grid_area
                    
                    ! Add to appropriate volume
                    if (delta_z >= 0.0) then
                        exca_volume = exca_volume + current_volume
                    else
                        fill_volume = fill_volume + abs(current_volume)
                    end if
                end if
            end if
        end do
    end do
    
    ! Calculate net volume
    grid_volume = exca_volume - fill_volume

end subroutine calc_volume

! Helper function to check if point is NaN
logical function isnan(x)
    real, intent(in) :: x
    isnan = (x /= x)
end function isnan

! Helper function to check if point is inside polygon
subroutine check_point_in_polygon(x, y, poly_x, poly_y, n, inside)
    implicit none
    real, intent(in) :: x, y
    integer, intent(in) :: n
    real, intent(in) :: poly_x(n), poly_y(n)
    logical, intent(out) :: inside
    
    integer :: i, j
    inside = .false.
    j = n
    
    do i = 1, n
        if ((poly_y(i) > y) .neqv. (poly_y(j) > y)) then
            if (x < (poly_x(j) - poly_x(i)) * (y - poly_y(i)) / &
                (poly_y(j) - poly_y(i)) + poly_x(i)) then
                inside = .not. inside
            end if
        end if
        j = i
    end do
end subroutine check_point_in_polygon 
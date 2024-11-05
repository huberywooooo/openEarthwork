subroutine calc_bc(base_x, base_y, n_base, surf_x, surf_y, n_surf, &
    contour_x, contour_y, n_contour)
    ! Calculate the convex hull boundary of the data points
    ! input:
    !   base_x, base_y   - base points coordinates
    !   surf_x, surf_y   - surface points coordinates
    !   n_base, n_surf   - number of points in base and surface
    ! output:
    !   contour_x, contour_y - boundary points coordinates
    !   n_contour            - number of contour points
    !
    !   openExcav: An Open Source Library for Excavation Calculation
    !   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    !   Copyright 2009-2024 Chongqing Three Gorges University
    
    implicit none
    
    ! Arguments
    integer, intent(in) :: n_base, n_surf
    real, intent(in) :: base_x(n_base), base_y(n_base)
    real, intent(in) :: surf_x(n_surf), surf_y(n_surf)
    real, allocatable, intent(out) :: contour_x(:), contour_y(:)
    integer, intent(out) :: n_contour
    
    ! Local variables
    integer :: n_total, i
    real, allocatable :: x(:), y(:)
    integer, allocatable :: hull_indices(:)
    
    ! Combine base and surface points
    n_total = n_base + n_surf
    allocate(x(n_total), y(n_total))
    
    ! Copy base points
    x(1:n_base) = base_x
    y(1:n_base) = base_y
    
    ! Copy surface points
    x(n_base+1:n_total) = surf_x
    y(n_base+1:n_total) = surf_y
    
    ! Calculate convex hull
    call compute_convex_hull(x, y, n_total, hull_indices, n_contour)
    
    ! Allocate and fill contour arrays
    allocate(contour_x(n_contour), contour_y(n_contour))
    do i = 1, n_contour
        contour_x(i) = x(hull_indices(i))
        contour_y(i) = y(hull_indices(i))
    end do
    
    ! Clean up
    deallocate(x, y, hull_indices)

end subroutine calc_bc
subroutine plot_results(x_surface, y_surface, n_surface, &
                       x_base, y_base, n_base, &
                       grid_x, grid_y, grid_z_surface, grid_z_base, nx, ny, &
                       contour_x, contour_y, n_contour, contour_level)
    ! Save the results data for plotting
    ! input:
    !   x_surface, y_surface     - surface point coordinates
    !   x_base, y_base          - base point coordinates
    !   grid_x, grid_y          - grid coordinates
    !   grid_z_surface, grid_z_base - interpolated elevation data
    !   contour_x, contour_y    - boundary points coordinates
    !   contour_level           - contour level value
    !
    !   openExcav: An Open Source Library for Excavation Calculation
    !   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    !   Copyright 2009-2024 Chongqing Three Gorges University
    
    implicit none
    
    ! Arguments
    integer, intent(in) :: n_surface, n_base, nx, ny, n_contour
    real, intent(in) :: x_surface(n_surface), y_surface(n_surface)
    real, intent(in) :: x_base(n_base), y_base(n_base)
    real, intent(in) :: grid_x(nx,ny), grid_y(nx,ny)
    real, intent(in) :: grid_z_surface(nx,ny), grid_z_base(nx,ny)
    real, intent(in) :: contour_x(n_contour), contour_y(n_contour)
    real, intent(in) :: contour_level
    
    ! Local variables
    integer :: i, j, unit_id
    
    ! Save scatter points data
    open(newunit=unit_id, file='scatter_points.dat', status='replace')
    write(unit_id, *) '# Surface points'
    do i = 1, n_surface
        write(unit_id, *) x_surface(i), y_surface(i)
    end do
    write(unit_id, *) '# Base points'
    do i = 1, n_base
        write(unit_id, *) x_base(i), y_base(i)
    end do
    close(unit_id)
    
    ! Save contour points
    open(newunit=unit_id, file='contour_points.dat', status='replace')
    do i = 1, n_contour
        write(unit_id, *) contour_x(i), contour_y(i)
    end do
    close(unit_id)
    
    ! Save grid surface data
    open(newunit=unit_id, file='grid_surface.dat', status='replace')
    do j = 1, ny
        do i = 1, nx
            write(unit_id, *) grid_x(i,j), grid_y(i,j), grid_z_surface(i,j)
        end do
        write(unit_id, *)  ! Empty line between rows for gnuplot
    end do
    close(unit_id)
    
    ! Save grid base data
    open(newunit=unit_id, file='grid_base.dat', status='replace')
    do j = 1, ny
        do i = 1, nx
            write(unit_id, *) grid_x(i,j), grid_y(i,j), grid_z_base(i,j)
        end do
        write(unit_id, *)  ! Empty line between rows for gnuplot
    end do
    close(unit_id)

end subroutine plot_results
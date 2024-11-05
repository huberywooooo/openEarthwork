program main
    !-----------------------------openExcav--------------------------------------
    !
    !   Description: Main program for calculating the volume of excavation
    !   Subroutines:
    !       format_data: format the data from the file
    !       set_params: set the parameters for the excavation calculation
    !       load_data: load the data from the file
    !       calc_bc: calculate the boundary of the excavation
    !       calc_grid: create the grid and interpolate the data
    !       plot_results: plot the results
    !       calc_volume: calculate the volume of the excavation
    !       print_results: print the results
    !
    !   openExcav: An Open Source Library for Excavation Calculation
    !   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    !   Copyright 2009-2024 Chongqing Three Gorges University
    
    implicit none
    
    ! Variables for data points
    real, allocatable :: base_x(:), base_y(:), base_z(:)
    real, allocatable :: surface_x(:), surface_y(:), surface_z(:)
    integer :: n_base, n_surface
    
    ! Variables for grid
    real, allocatable :: grid_x(:,:), grid_y(:,:)
    real, allocatable :: grid_z_surface(:,:), grid_z_base(:,:)
    integer :: nx, ny
    
    ! Variables for contour
    real, allocatable :: contour_x(:), contour_y(:)
    integer :: n_contour
    
    ! Parameters
    real :: grid_size, contour_level
    
    ! Volume results
    real :: exca_volume, fill_volume, total_volume
    
    ! Format the data files
    call format_data('base.txt', 'base1.txt')
    call format_data('surface.txt', 'surface1.txt')
    call format_data('rockbase.txt', 'rockbase1.txt')
    
    ! Set the parameters
    call set_params(grid_size, contour_level)
    
    ! Load the data (base data have an offset)
    call load_data('base.txt', base_x, base_y, base_z, n_base, 494400.0)
    call load_data('surface.txt', surface_x, surface_y, surface_z, n_surface)
    
    ! Calculate the boundary
    call calc_bc(base_x, base_y, n_base, &
                surface_x, surface_y, n_surface, &
                contour_x, contour_y, n_contour)
    
    ! Create the grid and interpolate
    call calc_grid(surface_x, surface_y, surface_z, n_surface, &
                  base_x, base_y, base_z, n_base, &
                  grid_size, &
                  grid_x, grid_y, grid_z_surface, grid_z_base, nx, ny)
    
    ! Plot the results
    call plot_results(surface_x, surface_y, n_surface, &
                     base_x, base_y, n_base, &
                     grid_x, grid_y, grid_z_surface, grid_z_base, nx, ny, &
                     contour_x, contour_y, n_contour, contour_level)
    
    ! Calculate the volume
    call calc_volume(grid_x, grid_y, grid_z_surface, grid_z_base, nx, ny, &
                    contour_x, contour_y, n_contour, grid_size, &
                    exca_volume, fill_volume, total_volume)
    
    ! Print the results
    call print_results(exca_volume, fill_volume, total_volume)
    
    ! Deallocate arrays
    deallocate(base_x, base_y, base_z)
    deallocate(surface_x, surface_y, surface_z)
    deallocate(grid_x, grid_y, grid_z_surface, grid_z_base)
    deallocate(contour_x, contour_y)
    
end program main 
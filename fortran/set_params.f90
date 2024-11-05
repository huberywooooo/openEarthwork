subroutine set_params(grid_size, contour_level)
    ! Set the calculation parameters
    ! output:
    !   grid_size     - size of the grid
    !   contour_level - level of the contour
    !
    !   openExcav: An Open Source Library for Excavation Calculation
    !   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    !   Copyright 2009-2024 Chongqing Three Gorges University
    
    implicit none
    real, intent(out) :: grid_size, contour_level
    
    ! Set the parameters
    grid_size = 5.0      ! grid size
    contour_level = 5.0  ! contour level

end subroutine set_params 
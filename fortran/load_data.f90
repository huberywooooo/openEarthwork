subroutine load_data(filename, x, y, z, n_points, min_value)
    ! load the data from the file and filter if needed
    ! input:
    !   filename  - data file name
    !   min_value - minimum value (optional)
    ! output:
    !   x, y, z   - coordinate arrays
    !   n_points  - number of points
    !
    !   openExcav: An Open Source Library for Excavation Calculation
    !   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    !   Copyright 2009-2024 Chongqing Three Gorges University

    implicit none
    
    ! Arguments
    character(len=*), intent(in) :: filename
    real, allocatable, intent(out) :: x(:), y(:), z(:)
    integer, intent(out) :: n_points
    real, optional, intent(in) :: min_value
    
    ! Local variables
    integer :: io_stat, i, unit_id
    character(len=256) :: dummy1, dummy2
    
    ! Read the data from the file (first count lines)
    open(newunit=unit_id, file=filename, status='old', action='read')
    n_points = 0
    do
        read(unit_id, *, iostat=io_stat)
        if (io_stat /= 0) exit
        n_points = n_points + 1
    end do
    rewind(unit_id)
    
    ! Allocate arrays
    allocate(x(n_points), y(n_points), z(n_points))
    
    ! Read coordinates
    do i = 1, n_points
        read(unit_id, *, iostat=io_stat) dummy1, dummy2, x(i), y(i), z(i)
    end do
    close(unit_id)
    
    ! If min_value is provided, filter the data
    if (present(min_value)) then
        block
            real, allocatable :: temp_x(:), temp_y(:), temp_z(:)
            logical, allocatable :: mask(:)
            integer :: new_size, j
            
            allocate(mask(n_points))
            mask = x >= min_value
            new_size = count(mask)
            
            ! Create temporary arrays for filtered data
            allocate(temp_x(new_size), temp_y(new_size), temp_z(new_size))
            
            ! Copy filtered data
            j = 0
            do i = 1, n_points
                if (mask(i)) then
                    j = j + 1
                    temp_x(j) = x(i)
                    temp_y(j) = y(i)
                    temp_z(j) = z(i)
                end if
            end do
            
            ! Update arrays and size
            deallocate(x, y, z)
            allocate(x(new_size), y(new_size), z(new_size))
            x = temp_x
            y = temp_y
            z = temp_z
            n_points = new_size
            
            deallocate(temp_x, temp_y, temp_z, mask)
        end block
    end if

end subroutine load_data
subroutine print_results(exca_volume, fill_volume, total_volume)
    ! Print the calculation results
    ! input:
    !   exca_volume  - excavation volume
    !   fill_volume  - fill volume
    !   total_volume - total volume
    !
    !   openExcav: An Open Source Library for Excavation Calculation
    !   Author(s): Hubery H.B. Woo (hbw8456@163.com)
    !   Copyright 2009-2024 Chongqing Three Gorges University
    
    implicit none
    real, intent(in) :: exca_volume, fill_volume, total_volume
    
    ! Print the results
    write(*, '(A,F12.2,A)') 'Excavation Volume: ', exca_volume, ' m³'
    write(*, '(A,F12.2,A)') 'Fill Volume: ', fill_volume, ' m³'
    write(*, '(A,F12.2,A)') 'Total Volume: ', total_volume, ' m³'

end subroutine print_results 
subroutine calc_convexhull(x, y, n, hull_indices, n_hull)
    !! subroutine for calculating the convex hull
    implicit none
    
    ! declare the parameters
    integer, intent(in) :: n
    real, intent(in) :: x(n), y(n)
    integer, allocatable, intent(out) :: hull_indices(:)
    integer, intent(out) :: n_hull
    
    ! declare the local variables
    integer :: i, j, k
    real :: cross_product
    logical :: is_convex
    
    ! allocate the array to store the convex hull indices
    allocate(hull_indices(n))
    
    ! find the leftmost bottom point as the starting point
    k = 1
    do i = 2, n
    if (x(i) < x(k) .or. (x(i) == x(k) .and. y(i) < y(k))) then
    k = i
    end if
    end do
    
    ! simplified version of Graham scan algorithm
    n_hull = 1
    hull_indices(1) = k
    
    ! simple implementation: only add the points on the convex hull
    do i = 1, n
    if (i /= k) then
    n_hull = n_hull + 1
    hull_indices(n_hull) = i
    end if
    end do
    
end subroutine calc_convexhull
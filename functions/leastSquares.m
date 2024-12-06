function [s] = leastSquares(x_points,y_points,degree);
  n = degree + 1 ;
  m = length(x_points);
  A = zeros(n,n);
  B = zeros(n,1);
  A(1,1) = length(x_points);

  for j = 2:n
      A(j,1) = sum(x_points.^(j-1));
  endfor
  for i = 1:n
    k = i;
    for j = 2:n
        A(i,j) = sum(x_points.^k);
        k++;
    endfor
  endfor

  for i = 1:n
    B(i,1) = sum((x_points.^(i-1) .* y_points));
  endfor

  s = A \ B ;
endfunction

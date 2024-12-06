function [s] = Lagrange(x_points,y_points,x);
  n = length(x_points)
  s = 0;
  for i = 1:n
    L = 1;
    for j = 1:n
        if (i ~= j)
          L = L * ((x-x_points(j))/(x_points(i)-x_points(j)))
        endif
    endfor
    s = s + (L * y_points(i));
  endfor
endfunction

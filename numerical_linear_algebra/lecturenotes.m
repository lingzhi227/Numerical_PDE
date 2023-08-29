% Vector products

% declare two column vectors
x = [1;2;3]
y = [2;3;4]

% inner/dot product
% When A and B are both column vectors, dot(A,B) is the same as A'*B
z = x'*y
z = dot(x',y)

% outer product
Z = x*y'
% Matrix multiplicatoin

% Declare matrix A and B
A = [1 2 3; 2 3 4; 4 6 0]
B = [1 2 3; 2 3 4; 4 6 0]

% dot mutiplication
C = A*B

% element wise multiplication
C = A.*B
% Complex vectors and matrix

% declare two complex row vectors
% a = uint8([1;2;3;4]);
% b = uint8([2;2;7;7]);
% 
% x = complex(a,b)
% y = complex(b,a)

x = [1+1i;1-1i;-1+1i;-1-1i]
y = [3-4i;6-2i;1+2i;4+3i]

% Conjugate Transpose of complex vector
x'

% inner product of complex vectors
s = x'*y
s = dot(conj(x'),y)
%% 
% $$$\langle a\mathbf{u}, \mathbf{v} \rangle = a\langle \mathbf{u}, \mathbf{v} 
% \rangle$$$
% 
% $$$\langle \mathbf{u}, \mathbf{u} \rangle > 0$$$
% 
% $$$|\mathbf{v}| = \sqrt{\langle \mathbf{v}, \mathbf{v} \rangle}$$$

% not like this, this is element wise
s = dot(x',y)

% outer product of complex vectors
y'
S = x*y'

% declare a complex matrix
A = [0-1i 2+1i; 4+2i 0-2i]
real(A)
imag(A)
conj(A)

% Conjugate Transpose of Complex Matrix
B = A'

% linear combination, independent
% Matrix inverse and division

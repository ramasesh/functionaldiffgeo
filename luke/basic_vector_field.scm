(load "basic_manifold.scm")

; Define method of creating vector fields
; Vector fields are functions which take in a manifold function f and a point m on the manifold and return the directional derivative of f at point m
; One way of defining a vector field is by using its component function. A component function takes a manifold point m and returns a tuple of increments in each direction of the coordinate system.
; If you are given some vector field v, you can apply it to the chart of your chosen coordinate system and get the components. This makes sense because applying a vector field to the ith component of the chart function gives you how much that ith coordinate changes at the point m due to that vector field v.
; If you have the component tuple at point m and contract it with the derivative of the coordinate representation of the function f (can get this by (compose f (point coordsys))) evaluated at ((chart coordsys) m), then you'll have the directional derivative of the function f in the direction of v at m. This is independent of the coordinate system used to define f, v, and m.

; components: takes in coordinates and gives out a tuple of increments
; coordsys: coordinate system used to define components (R2-rect, R2-polar, etc.)
; procedure->vector-field takes in some function which has the format of a vector field and returns an object which can be raised to a power and takes consecutive derivatives
(define (components->vector-field components coordsys)
  (define (v f)
    (compose (* (D (compose f (point coordsys))) 
		components)
	     (chart coordsys)))
  (procedure->vector-field v))

; Use the components->vector-field function to define a literal vector field
(define v
  (components->vector-field
   (up (literal-function 'b^0 R2->R)
       (literal-function 'b^1 R2->R))
   R2-rect))

; Apply vector field v to manifold function f at point m
((v f) R2-rect-point)

; Another way of defining a literal vector field is to use the literal-vector-field function
(define v-literal (literal-vector-field 'b R2-rect))

; Convert the vector field to a polar representation
(define components-polar (compose (v (chart R2-polar)) (point R2-polar)))
(define v-from-polar
  (components->vector-field components-polar R2-polar))

; Apply the polar representation of the vector field to f at point R2-rect-point
; Even though v-from-polar has been defined in terms of the polar coordinate representation of the components, it still just lives in the manifold
((v-from-polar f) R2-rect-point)

; Coordinatizing a vector field creates a function that takes in a function f defined on coordinates and a point and returns a real number
(define (coordinatize v coordsys)
  (define (coordinatized-v f)
    (let ((b (compose (v (chart coordsys))
		      (point coordsys))))
      (* (D f) b)))
  (make-operator coordinatized-v))

; One can also add vector fields together
(define u (literal-vector-field 'c R2-rect))
(((+ u v) f) R2-rect-point)
(((* u 'alpha) f) R2-rect-point)

































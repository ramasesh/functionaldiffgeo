; Define R2 manifold and a patch at the origin
(define R2 (make-manifold R^n 2))
(define U (patch 'origin R2))

; Define rectangular and polar coordinate systems for the origin patch on the manifold
(define R2-rect (coordinate-system 'rectangular U))
(define R2-polar (coordinate-system 'polar/cylindrical U))

; Create manifold points defined by polar and rectangular coordinates
(define R2-rect-point ((point R2-rect) (up 'x0 'y0)))
(define R2-polar-point ((point R2-polar) (up 'r0 't0)))

; Used when creating functions from R2 to R
(define R2->R (-> (UP Real Real) Real))

; Create function defined on the manifold using the rectangular coordinate system
(define f
  (compose (literal-function 'f-rect R2->R)
	   (chart R2-rect)))
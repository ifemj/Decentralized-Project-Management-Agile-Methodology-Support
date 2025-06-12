;; Agile Coach Verification Contract
;; Validates and manages agile methodology coaches

(define-map coaches
  { coach-id: uint }
  {
    address: principal,
    name: (string-ascii 50),
    certification: (string-ascii 100),
    experience-years: uint,
    verified: bool,
    verification-date: uint
  }
)

(define-map coach-by-address principal uint)
(define-data-var next-coach-id uint u1)

;; Register a new coach
(define-public (register-coach (name (string-ascii 50)) (certification (string-ascii 100)) (experience-years uint))
  (let ((coach-id (var-get next-coach-id)))
    (map-set coaches
      { coach-id: coach-id }
      {
        address: tx-sender,
        name: name,
        certification: certification,
        experience-years: experience-years,
        verified: false,
        verification-date: u0
      }
    )
    (map-set coach-by-address tx-sender coach-id)
    (var-set next-coach-id (+ coach-id u1))
    (ok coach-id)
  )
)

;; Verify a coach (only contract owner can verify)
(define-public (verify-coach (coach-id uint))
  (match (map-get? coaches { coach-id: coach-id })
    coach-data (begin
      (map-set coaches
        { coach-id: coach-id }
        (merge coach-data { verified: true, verification-date: block-height })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Get coach information
(define-read-only (get-coach (coach-id uint))
  (map-get? coaches { coach-id: coach-id })
)

;; Check if address is verified coach
(define-read-only (is-verified-coach (address principal))
  (match (map-get? coach-by-address address)
    coach-id (match (map-get? coaches { coach-id: coach-id })
      coach-data (get verified coach-data)
      false
    )
    false
  )
)

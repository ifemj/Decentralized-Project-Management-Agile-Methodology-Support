;; Backlog Coordination Contract
;; Coordinates project backlogs

(define-map backlogs
  { project-id: uint }
  {
    owner: principal,
    name: (string-ascii 50),
    description: (string-ascii 200)
  }
)

(define-map backlog-items
  { project-id: uint, item-id: uint }
  {
    title: (string-ascii 100),
    description: (string-ascii 500),
    priority: uint,
    story-points: uint,
    status: (string-ascii 20),
    created-by: principal,
    assigned-sprint: (optional uint)
  }
)

(define-data-var next-project-id uint u1)
(define-data-var next-item-id uint u1)

;; Create a new backlog
(define-public (create-backlog (name (string-ascii 50)) (description (string-ascii 200)))
  (let ((project-id (var-get next-project-id)))
    (map-set backlogs
      { project-id: project-id }
      {
        owner: tx-sender,
        name: name,
        description: description
      }
    )
    (var-set next-project-id (+ project-id u1))
    (ok project-id)
  )
)

;; Add item to backlog
(define-public (add-backlog-item
  (project-id uint)
  (title (string-ascii 100))
  (description (string-ascii 500))
  (priority uint)
  (story-points uint)
)
  (match (map-get? backlogs { project-id: project-id })
    backlog-data (let ((item-id (var-get next-item-id)))
      (map-set backlog-items
        { project-id: project-id, item-id: item-id }
        {
          title: title,
          description: description,
          priority: priority,
          story-points: story-points,
          status: "new",
          created-by: tx-sender,
          assigned-sprint: none
        }
      )
      (var-set next-item-id (+ item-id u1))
      (ok item-id)
    )
    (err u404)
  )
)

;; Update item priority
(define-public (update-item-priority (project-id uint) (item-id uint) (new-priority uint))
  (match (map-get? backlog-items { project-id: project-id, item-id: item-id })
    item-data (begin
      (map-set backlog-items
        { project-id: project-id, item-id: item-id }
        (merge item-data { priority: new-priority })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Assign item to sprint
(define-public (assign-to-sprint (project-id uint) (item-id uint) (sprint-id uint))
  (match (map-get? backlog-items { project-id: project-id, item-id: item-id })
    item-data (begin
      (map-set backlog-items
        { project-id: project-id, item-id: item-id }
        (merge item-data { assigned-sprint: (some sprint-id), status: "assigned" })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Get backlog details
(define-read-only (get-backlog (project-id uint))
  (map-get? backlogs { project-id: project-id })
)

;; Get backlog item
(define-read-only (get-backlog-item (project-id uint) (item-id uint))
  (map-get? backlog-items { project-id: project-id, item-id: item-id })
)

--INSERTAR PROPIETARIO
--INSERT INTO owners
(
    first_name,
    last_name,
    company_name,
    email,
    phone,
    tax_id,
    country
)
VALUES(
    'Martha',
    'Santos',
    'Turismo SV',
    'martha@turismosv.com',
    '7230-8888',
    'SV-2026-001',
    'El Salvador'
);

--SELECT * FROM owners ORDER BY owner_id DESC LIMIT 1;

--SELECT * FROM accommodations LIMIT 1;

-- 02. INSERTAR ALOJAMIENTO

INSERT INTO accommodations
(
    owner_id,
    accommodation_type_id,
    location_id,
    name,
    description,
    max_guests,
    bedroom_count,
    bathroom_count,
    base_price_per_night,
    currency_code,
    check_in_time,
    check_out_time,
    is_active
)
VALUES
(
   1,
   1,
   1,
   'Hotel Arucha',
   'Alojamiento creado para practica SQL',
   4,
   2,
   1,
   75.00,
   'USD',
   '14:00:00',
   '11:00:00',
   TRUE
);

--SELECT * FROM accommodations ORDER BY accommodation_id DESC LIMIT 1;

-- 03. INSERTAR HUESPED Y RESERVA

INSERT INTO guests
(
    first_name,
    last_name,
    email,
    phone,
    date_of_birth,
    nationality
)
VALUES
(
    'Dionisio',
    'Arucha',
    'darucha@turismosv.com',
    '7603-2222',
    '24/03/1962',
    'Salvadoreño'
);

SELECT *
FROM guests
WHERE first_name = 'Dionisio'
AND last_name = 'Arucha';


-- 04. INSERTAR PAGO

INSERT INTO payments
(
    booking_id,
    payment_date,
    amount,
    payment_method,
    payment_status,
    transaction_reference
)
VALUES
(
    1,
    '2026-06-15',
    125.50,
    'Credit Card',
    'Completed',
    'TXN-2026-001'
);

SELECT * FROM payments ORDER BY payment_id DESC LIMIT 1;

-- 5. Alojamientos activos

SELECT * FROM accommodations
WHERE is_active = TRUE;

-- 6. Huespedes por país

SELECT * FROM guests
WHERE nationality = 'Salvadoreño';

-- 7. Reservas por fecha

SELECT * FROM bookings
WHERE check_in_date
BETWEEN '2026-01-01' AND '2026-12-31';

-- 8. Actualizar precio

UPDATE accommodations
SET base_price_per_night = 100.00
WHERE name = 'Hotel Arucha';

-- 9. Estado reserva (UPDATE BOOKING STATUS)

UPDATE bookings
SET booking_status_id = 2
WHERE booking_id = 1;

-- 10. DELETE REVIEW

DELETE FROM reviews
WHERE review_id = 1;

-- 11. BOOKINGS + GUEST (INNER JOIN)

SELECT
    b.booking_id,
    g.first_name,
    g.last_name,
    b.check_in_date,
    b.check_out_date
FROM bookings b
INNER JOIN guests g
ON b.guest_id = g.guest_id;

-- 12. COMPLETE ACCOMMODATION (MULTIPLE INNER JOIN)

SELECT
    a.accommodation_id,
    a.name AS accommodation_name,
    o.first_name,
    o.last_name,
    at.type_name AS accommodation_type
FROM accommodations a
INNER JOIN owners o
    ON a.owner_id = o.owner_id
INNER JOIN accommodation_types at
    ON a.accommodation_type_id = at.accommodation_type_id;

-- 13. PAGOS + RESERVAS (PAYMENTS + BOOKINGS)

SELECT
    p.payment_id,
    p.amount,
    p.payment_method,
    p.payment_status,
    b.booking_id
FROM payments p
INNER JOIN bookings b
    ON p.booking_id = b.booking_id;

-- 14. SIN RESEÑAS (ACCOMMODATIONS WITHOUT REVIEWS)

SELECT
    a.accommodation_id,
    a.name,
    r.review_id
FROM accommodations a
LEFT JOIN reviews r
    ON a.accommodation_id = r.accommodation_id;

-- 15. SIN RESERVAS (ACCOMMODATIONS WITHOUT BOOKINGS)

SELECT
    a.accommodation_id,
    a.name
FROM accommodations a
LEFT JOIN bookings b
    ON a.accommodation_id = b.accommodation_id
WHERE b.booking_id IS NULL;

-- 16. TOTAL INGRESOS (TOTAL REVENUE)

SELECT
    SUM(amount) AS total_ingresos
FROM payments;

-- 17. PROMEDIO RATING (AVERAGE RATING)

SELECT
    AVG(rating) AS promedio_rating
FROM reviews;

-- 18. TOP ALOJAMIENTOS (TOP ACCOMMODATIONS)

SELECT
    a.accommodation_id,
    a.name,
    COUNT(b.booking_id) AS total_reservas
FROM accommodations a
INNER JOIN bookings b
    ON a.accommodation_id = b.accommodation_id
GROUP BY a.accommodation_id, a.name
ORDER BY total_reservas DESC
LIMIT 5;

-- 19. MAS DE 3 RESERVAS (ACCOMMODATIONS WITH MORE THAN 3 BOOKINGS)

SELECT
    a.accommodation_id,
    a.name,
    COUNT(b.booking_id) AS total_reservas
FROM accommodations a
INNER JOIN bookings b
    ON a.accommodation_id = b.accommodation_id
GROUP BY a.accommodation_id, a.name
HAVING COUNT(b.booking_id) > 3;

-- 20. ALOJAMIENTO MAS CARO (MOST EXPENSIVE ACCOMMODATION)

SELECT *
FROM accommodations
WHERE base_price_per_night =
(
    SELECT MAX(base_price_per_night)
    FROM accommodations
);

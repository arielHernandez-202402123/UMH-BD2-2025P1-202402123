erDiagram
    Participante ||--o{ Reserva : realiza
    Hotel ||--o{ Reserva : tiene
    TipoHabitacion ||--o{ Reserva : aplica_a
    Reserva ||--|| MetodoPago : garantiza
    Hotel ||--o{ PrecioHabitacion : establece
    TipoHabitacion ||--o{ PrecioHabitacion : define
    Hotel ||--o{ DisponibilidadHabitacion : gestiona
    TipoHabitacion ||--o{ DisponibilidadHabitacion : controla
    Hotel ||--o{ Habitacion : posee
    TipoHabitacion ||--o{ Habitacion : categoriza
    Habitacion ||--o{ Reserva : asignada_a

    Participante {
        int id_participante PK
        string nombre
        string apellido
        string organizacion
        string cargo
        string num_pasaporte
        date fecha_nacimiento
        string nacionalidad
        string direccion
        string ciudad
        string pais
        string telefono
        string fax
        string email
    }

    Hotel {
        int id_hotel PK
        string nombre_hotel
        string direccion_hotel
        string contacto_nombre
        string contacto_cargo
        string telefono
        string fax
        string email
    }

    TipoHabitacion {
        int id_tipo_habitacion PK
        string nombre_tipo
        string descripcion
    }

    PrecioHabitacion {
        int id_precio PK
        int id_hotel FK
        int id_tipo_habitacion FK
        decimal precio_single
        decimal precio_doble
        decimal precio_twin
        string moneda
    }

    Reserva {
        int id_reserva PK
        int id_participante FK
        int id_hotel FK
        int id_tipo_habitacion FK
        int id_habitacion FK
        date fecha_arribo
        date fecha_salida
        int num_noches
        string vuelo_arribo
        string vuelo_salida
        boolean early_check_in
        string estado_reserva
    }

    MetodoPago {
        int id_pago PK
        int id_reserva FK
        string tipo_tarjeta
        string numero_tarjeta
        date fecha_vencimiento
        string nombre_titular
        string firma_titular
    }

    DisponibilidadHabitacion {
        int id_disponibilidad PK
        int id_hotel FK
        int id_tipo_habitacion FK
        date fecha
        int habitaciones_existentes
        int habitaciones_ocupadas
        int habitaciones_disponibles
        string temporada
    }

    Habitacion {
        int id_habitacion PK
        int id_hotel FK
        string numero_habitacion
        int id_tipo_habitacion FK
        int piso
        string estado
    }

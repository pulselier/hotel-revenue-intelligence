let
    // Replace the path below with the full path to hotel_bookings_clean.csv.
    Source = Csv.Document(
        File.Contents("C:\PATH\TO\hotel_bookings_clean.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    TypedColumns = Table.TransformColumnTypes(PromotedHeaders, {
        {"hotel", type text}, {"is_canceled", Int64.Type}, {"lead_time", Int64.Type},
        {"arrival_date_year", Int64.Type}, {"arrival_date_month", type text},
        {"arrival_date_week_number", Int64.Type}, {"arrival_date_day_of_month", Int64.Type},
        {"stays_in_weekend_nights", Int64.Type}, {"stays_in_week_nights", Int64.Type},
        {"adults", Int64.Type}, {"children", type number}, {"babies", Int64.Type},
        {"meal", type text}, {"country", type text}, {"market_segment", type text},
        {"distribution_channel", type text}, {"is_repeated_guest", Int64.Type},
        {"previous_cancellations", Int64.Type}, {"previous_bookings_not_canceled", Int64.Type},
        {"reserved_room_type", type text}, {"assigned_room_type", type text},
        {"booking_changes", Int64.Type}, {"deposit_type", type text}, {"agent", type text},
        {"days_in_waiting_list", Int64.Type}, {"customer_type", type text}, {"adr", type number},
        {"required_car_parking_spaces", Int64.Type}, {"total_of_special_requests", Int64.Type},
        {"reservation_status", type text}, {"reservation_status_date", type date},
        {"arrival_month_num", Int64.Type}, {"arrival_date", type date},
        {"total_nights", Int64.Type}, {"total_guests", type number},
        {"estimated_booking_revenue", type number}, {"booking_year_month", type text},
        {"cancellation_status", type text}, {"guest_status", type text}
    }, "en-US")
in
    TypedColumns

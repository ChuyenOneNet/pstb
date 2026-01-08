import 'package:json_annotation/json_annotation.dart';

part 'crm_booking_item.g.dart';

@JsonSerializable()
class CrmBookingItem {
  // ===== Core IDs =====
  final String? id; // thường trùng "cpbookingid"
  final String? cpbookingid;
  final String? cpbooking_no;

  // ===== Status =====
  final String? cpbooking_status; // confirmed/unconfirmed/checked_in...
  final String? cpbooking_remind_status;
  final String? sync_his_status; // success/failed/...

  // ===== Contact (patient) =====
  final String? related_contact; // id contact
  final String? related_contact_label; // tên bệnh nhân
  final String? related_contactmobile;
  final String? related_contactidentification_number;
  final String? related_contactbirthday;

  // ===== Booking time =====
  final String? start_day; // "2025-12-26"
  final String? start_time; // "09:00:00" or null
  final String? cpbooking_shift; // "Morning shift"...

  // ===== Specialty/Department =====
  final String? related_cpspecialtycategory;
  final String? related_cpspecialtycategory_label;

  // ===== Note / Source =====
  final String? note;
  final String? cpbooking_source;

  // ===== Ownership / meta =====
  final String? main_owner_id;
  final String? main_owner_name;
  final List<dynamic>? assigned_owners;

  // ===== Timestamps =====
  final String? createdtime;
  final String? modifiedtime;

  // ------------------------------------------------------------
  // Backward compatibility (nếu code cũ còn dùng các field này).
  // Có thể remove nếu chắc chắn không dùng nữa.
  // ------------------------------------------------------------
  final String? patient_name;
  final String? patientName;
  final String? firstname;
  final String? last_name;

  final String? service_name;
  final String? serviceName;
  final String? leads_interest_service;

  final String? branch;
  final String? status;

  CrmBookingItem({
    this.id,
    this.cpbookingid,
    this.cpbooking_no,
    this.cpbooking_status,
    this.cpbooking_remind_status,
    this.sync_his_status,
    this.related_contact,
    this.related_contact_label,
    this.related_contactmobile,
    this.related_contactidentification_number,
    this.related_contactbirthday,
    this.start_day,
    this.start_time,
    this.cpbooking_shift,
    this.related_cpspecialtycategory,
    this.related_cpspecialtycategory_label,
    this.note,
    this.cpbooking_source,
    this.main_owner_id,
    this.main_owner_name,
    this.assigned_owners,
    this.createdtime,
    this.modifiedtime,

    // legacy
    this.patient_name,
    this.patientName,
    this.firstname,
    this.last_name,
    this.service_name,
    this.serviceName,
    this.leads_interest_service,
    this.branch,
    this.status,
  });

  factory CrmBookingItem.fromJson(Map<String, dynamic> json) =>
      _$CrmBookingItemFromJson(json);

  Map<String, dynamic> toJson() => _$CrmBookingItemToJson(this);
}

class JobApplication {
  final String id;
  final String name;
  final String jobListingId;
  final String? appliedDate;
  final String contactNumber;
  final String status;

  JobApplication({
    required this.id,
    required this.name,
    required this.jobListingId,
    required this.appliedDate,
    required this.contactNumber,
    required this.status,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['Id'],
      name: json['Name'],
      jobListingId: json['Job_Listing__c'],
      appliedDate: json['Applied_Date__c'],
      contactNumber: json['Labour__r'] != null
          ? json['Labour__r']['Contact_Number__c']
          : json['Labour_Contact_Number__c'] ?? 'N/A',
      status: json['Status__c'],
    );
  }
}

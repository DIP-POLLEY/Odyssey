class JobListing {
  final String name;
  final String farmerName;
  final String contactNumber;
  final String? startDate;
  final String? endDate;
  final String location;
  final String payRate;
  final String skill;
  final String status;
  final double workersRequired;
  final String farmName;

  JobListing({
    required this.name,
    required this.farmerName,
    required this.contactNumber,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.payRate,
    required this.skill,
    required this.status,
    required this.workersRequired,
    required this.farmName,
  });

  factory JobListing.fromJson(Map<String, dynamic> json) {
    return JobListing(
      name: json['Name'],
      farmerName: json['Farmer_Name__c'],
      contactNumber: json['Farmer_Contact_Number__c'],
      startDate: json['Start_Date__c'],
      endDate: json['End_Date__c'],
      location: json['Location__c'],
      payRate: json['Pay_Rate__c'],
      skill: json['Skill__c'],
      status: json['Status__c'],
      workersRequired: (json['Number_of_workers_required__c'] as num).toDouble(),
      farmName: json['Farm_Name__c'],
    );
  }
}

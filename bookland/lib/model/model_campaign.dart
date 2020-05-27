// TODO Implement this library.
import 'package:flutter/foundation.dart';


class Campaign{
  String campaignId;
  String couponCode;
  String couponDiscount;
  String campaignName;
  String endDate;
  int participantQuantity;

  Campaign({
    this.campaignId,
    this.couponCode,
    this.couponDiscount,
    this.campaignName,
    this.endDate,
    this.participantQuantity
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      campaignId: json['CampaignId'],
      couponCode: json['CouponCode'],
      couponDiscount: json['CouponDiscount'],
      campaignName: json['CampaignName'],
      endDate: json['EndDate'],
      participantQuantity: json['ParticipantQuantity'],
    );
  }

}
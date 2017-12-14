//
//  User.m
//  Meishii
//
//  Created by Develop Mx on 29/08/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import "User.h"

@interface User() {
    NSString* _identifier;
    NSString* _email;
    NSString* _workEmail;
    NSString* _firstName;
    NSString* _lastName;
    
    Card* _card;
    NSString* _profession;
    
    NSString* _telephone1;
    NSString* _telephone2;
    
    NSString* _street;
    NSString* _number;
    NSString* _neighborhood;
    NSString* _city;
    NSString* _zipCode;
    
    NSString* _website;
    NSString* _twitter;
    NSString* _facebook;
    NSString* _instagram;
    NSString* _bio;
    NSURL* _logo;
    
    NSURL* _qrImage;
    NSURL* _profilePicture;
    
    NSNumber* _distance;
    NSNumber* _followers;
    NSNumber* _following;
    
    Review *_review;
    

    BOOL _isContact;
}
@end

@implementation User

- (id) initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        _identifier = [dictionary objectForKey:@"id"];
        _email      = [dictionary objectForKey:@"email"];
        _workEmail  = [dictionary objectForKey:@"work_email"];
        _firstName  = [dictionary objectForKey:@"name"];
        _lastName   = [dictionary objectForKey:@"last_name"];
        
        _telephone1 = [dictionary objectForKey:@"telephone1"];
        _telephone2 = [dictionary objectForKey:@"telephone2"];
        
        _street       = [dictionary objectForKey:@"street"];
        _number       = [dictionary objectForKey:@"number"];
        _neighborhood = [dictionary objectForKey:@"neighborhood"];
        _city         = [dictionary objectForKey:@"city"];
        _zipCode      = [dictionary objectForKey:@"zip_code"];
        
        _website  = [dictionary objectForKey:@"website"];
        _twitter  = [dictionary objectForKey:@"twitter"];
        _facebook = [dictionary objectForKey:@"facebook"];
        _instagram = [dictionary objectForKey:@"instagram"];
        
        _distance  = [dictionary objectForKey:@"distance"];
        _followers = [dictionary objectForKey:@"followers_count"];
        _following = [dictionary objectForKey:@"following_count"];
        _bio       = [dictionary objectForKey:@"bio"];
        
        NSNull *nul = [NSNull null];
        
        if ([dictionary objectForKey:@"logo"] && [dictionary objectForKey:@"logo"] != nul)
            _logo     = [NSURL URLWithString:[dictionary objectForKey:@"logo"]];
        
        if ([dictionary objectForKey:@"qr_image"] && [dictionary objectForKey:@"qr_image"] != nul)
            _qrImage  = [NSURL URLWithString:[dictionary objectForKey:@"qr_image"]];
        
        if ([dictionary objectForKey:@"profile_picture"] && [dictionary objectForKey:@"profile_picture"] != nul)
            _profilePicture  = [NSURL URLWithString:[dictionary objectForKey:@"profile_picture"]];
        
        if([dictionary objectForKey:@"contact"] && [dictionary objectForKey:@"contact"] != nul)
            _isContact = [[dictionary objectForKey:@"contact"] boolValue];
        if ([dictionary objectForKey:@"review"] && [dictionary objectForKey:@"degree_v"] != nul)
            _review = [[Review alloc] initWithDictionary:[dictionary objectForKey:@"review"]];
        if ([dictionary objectForKey:@"profession"] && [dictionary objectForKey:@"profession"] != nul)
            _profession = [dictionary objectForKey:@"profession"];
        if ([dictionary objectForKey:@"card"] && [dictionary objectForKey:@"card"] != nul)
            _card = [[Card alloc] initWithDictionary:[dictionary objectForKey:@"card"]];
    }
    return self;
}

- (void)setIdentifier:(NSString *)identifier {
    _identifier = [identifier copy];
}

-(void)setEmail:(NSString *)email {
    _email = [email copy];
}

-(void)setWorkEmail:(NSString *)workEmail {
    _workEmail = [workEmail copy];
}

-(void)setFirstName:(NSString *)firstName {
    _firstName = [firstName copy];
}

-(void)setLastName:(NSString *)lastName {
    _lastName = [lastName copy];
}

-(void)setCard:(Card *)card {
    _card = card;
}

-(void)setTelephone1:(NSString *)telephone1 {
    _telephone1 = [telephone1 copy];
}

-(void)setTelephone2:(NSString *)telephone2 {
    _telephone2 = [telephone2 copy];
}


-(void)setProfession:(NSString *)profession {
    _profession = profession;
}

-(void)setStreet:(NSString *)street {
    _street = [street copy];
}

-(void)setNumber:(NSString *)number {
    _number =  [number copy];
}

-(void)setNeighborhood:(NSString *)neighborhood {
    _neighborhood = [neighborhood copy];
}

-(void)setCity:(NSString *)city {
    _city = [city copy];
}

-(void)setZipCode:(NSString *)zipCode {
    _zipCode = [zipCode copy];
}

-(void)setWebsite:(NSString *)website {
    _website = [website copy];
}

-(void)setTwitter:(NSString *)twitter {
    _twitter = [twitter copy];
}

-(void)setFacebook:(NSString *)facebook {
    _facebook = [facebook copy];
}
-(void)setInstagram:(NSString *) instagram {
    _instagram = [instagram copy];
}

-(void)setBio:(NSString *) bio {
    _bio = [bio copy];
}

-(void)setLogo:(NSURL *)logo {
    _logo = [logo copy];
}

-(void)setQrImage:(NSURL *)qrImage {
    _qrImage = [qrImage copy];
}

-(void)setProfilePicture:(NSURL *)profilePicture {
    _profilePicture = [profilePicture copy];
}

-(void)setIsContact:(BOOL)isContact {
    _isContact = isContact;
}


-(NSString *)identifier {
    if ([_identifier isEqual:[NSNull null]])
        return @"";
    return _identifier;
    
}

-(NSString *)email {
    if ([_email isEqual:[NSNull null]])
        return @"";
    return _email;
}

-(NSString *)workEmail {
    if ([_workEmail isEqual:[NSNull null]])
        return @"";
    return _workEmail;
}

-(NSString *)showName {
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}

-(NSString *)firstName {
    if ([_firstName isEqual:[NSNull null]])
        return @"";
    return _firstName;
}

-(NSString *)lastName {
    if ([_lastName isEqual:[NSNull null]])
        return @"";
    return _lastName;
}

-(Card *) card {
    return _card;
}

-(NSString *) telephone1 {
    if ([_telephone1 isEqual:[NSNull null]])
        return @"";
    return _telephone1;
}

-(NSString *) telephone2 {
    if ([_telephone2 isEqual:[NSNull null]])
        return @"";
    return _telephone2;
}


-(NSString *) profession {
    return _profession;
}


-(NSString *) street {
    if ([_street isEqual:[NSNull null]] || _street == nil)
        return nil;
    return _street;
}

-(NSString *) number {
    if ([_number isEqual:[NSNull null]] || _number == nil)
        return nil;
    return _number;
}

-(NSString *) neighborhood {
    if ([_neighborhood isEqual:[NSNull null]] || _neighborhood == nil)
        return nil;
    return _neighborhood;
}

-(NSString *) city {
    if ([_city isEqual:[NSNull null]] || _city == nil)
        return nil;
    return _city;
}

-(NSString *) zipCode {
    if ([_zipCode isEqual:[NSNull null]] || _zipCode == nil)
        return nil;
    return _zipCode;
}

-(NSString *) website {
    if ([_website isEqual:[NSNull null]])
        return @"";
    return _website;
}

-(NSString *) twitter {
    if ([_twitter isEqual:[NSNull null]])
        return @"";
    return _twitter;
}

-(NSString *) facebook {
    if ([_facebook isEqual:[NSNull null]])
        return @"";
    return _facebook;
}

-(NSString *) instagram {
    if ([_instagram isEqual:[NSNull null]])
        return @"";
    return _instagram;
}

-(NSString *) bio {
    if ([_bio isEqual:[NSNull null]])
        return @"";
    return _bio;
}

-(NSURL *) logo {
    if ([_logo isEqual:[NSNull null]])
        return nil;
    return _logo;
}

-(NSURL *) qrImage {
    if ([_qrImage isEqual:[NSNull null]])
        return nil;
    return _qrImage;
}

-(NSURL *) profilePicture {
    if ([_profilePicture isEqual:[NSNull null]])
        return nil;
    return _profilePicture;
}

-(NSNumber *) distance {
    if ([_distance isEqual:[NSNull null]])
        return 0;
    return _distance;
}

-(NSNumber *) followers {
    if ([_followers isEqual:[NSNull null]])
        return 0;
    return _followers;
}

-(NSNumber *) following {
    if ([_following isEqual:[NSNull null]])
        return 0;
    return _following;
}

-(NSDictionary*) info {
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    if (_workEmail != nil)
        [dictionary setValue:[NSString stringWithFormat:@"e#%@", [self workEmail]] forKey:@"Email"];
    
    [dictionary setValue:[NSString stringWithFormat:@"%@ %@", _firstName, _lastName] forKey:@"Name"];
    
    
    if (_profession != nil)
        [dictionary setValue:_profession forKey:@"Profession"];
    
    if (_telephone1 != nil)
        [dictionary setValue:[NSString stringWithFormat:@"p#%@", [self telephone1]] forKey:@"Telephone 1"];
    if (_telephone2 != nil)
        [dictionary setValue:[NSString stringWithFormat:@"p#%@", [self telephone2]] forKey: @"Telephone 2"];
    
    if ([self address] )
        [dictionary setValue:[NSString stringWithFormat:@"m#%@", [self address]] forKey: @"Address"];
 
    if (_website != nil)
        [dictionary setValue:[NSString stringWithFormat:@"w#%@", [self website]] forKey:@"Website"];
    if (_twitter != nil)
        [dictionary setValue:[NSString stringWithFormat:@"t#%@", [self twitter]] forKey:@"Twitter"];
    if (_facebook != nil)
        [dictionary setValue:[NSString stringWithFormat:@"f#%@", [self facebook]] forKey:@"Facebook"];
    
    
    [dictionary setValue:[NSString stringWithFormat:@"fm#%@", [self followers]] forKey:@"Followers"];
    [dictionary setValue:[NSString stringWithFormat:@"if#%@", [self following]] forKey:@"Following"];
    
    return dictionary;
}

-(NSMutableArray*) infoKeys {
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    [array addObject:@"Name"];
    [array addObject:@"Followers"];
    [array addObject:@"Following"];
    
    if (_telephone1 != nil)
        [array addObject:@"Telephone 1"];
    if (_telephone2 != nil)
        [array addObject:@"Telephone 2"];
    
    if (_profession != nil)
        [array addObject:@"Profession"];
    
    [array addObject:@"Email"];
    
    if ([self address] )
        [array addObject:@"Address"];
    
    if (_facebook != nil)
        [array addObject:@"Facebook"];
    if (_twitter != nil)
        [array addObject:@"Twitter"];
    if (_website != nil)
        [array addObject:@"Website"];

    return array;
}

-(NSString *)address {
    if ([self street] || [self number] || [self neighborhood] || [self city]) {
        NSString* fullAddress = nil;
        if ([self street])
            fullAddress= [NSString stringWithFormat:@"%@", _street];
        if ([self number])
            fullAddress = [NSString stringWithFormat:@"%@ %@\n", fullAddress, _number];
        if ([self neighborhood])
            fullAddress = [NSString stringWithFormat:@"%@ %@", fullAddress, _neighborhood];
        
        if ([self city])
            fullAddress = [NSString stringWithFormat:@"%@ %@", fullAddress, _city];
        
        return fullAddress;
    } else {
        return nil;
    }
}

@end

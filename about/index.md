---
title: 关于
date: 2018-01-06 20:57:21
type: about
comments: false
---

```
/*
This is a simple C++ program about me
*/

#include "stdafx.h"
#include <algorithm> 
#incluce <string>
#include <iostream>
#include <list>

// set and get attrib macro
#define GET_ATTRIBUTE(attrname) get##_##attrname
#define SET_ATTRIBUTE(attrname) set##_##attrname

#define SET_ATTRIBUTE_INVOKE(attrname, value) SET_ATTRIBUTE(attrname)(value)
#define GET_ATTRIBUTE_INVOKE(attrname)        GET_ATTRIBUTE(attrname)()

#define GET_ATTRIBUTE_DECL(attrtype, attrname) attrtype & GET_ATTRIBUTE(attrname)()
#define SET_ATTRIBUTE_DECL(attrtype, attrname) void SET_ATTRIBUTE(attrname)(attrtype attrname)

#define GET_ATTRIBUTE_IMPL(attrtype, attrname) GET_ATTRIBUTE_DECL(attrtype, attrname) \
{\
   return _##attrname;\
}
#define SET_ATTRIBUTE_IMPL(attrtype, attrname) SET_ATTRIBUTE_DECL(attrtype, attrname) \
{\
    _##attrname = attrname;\
}

// A function for deleting an object.  Handy for being used as a functor.
template <typename T>
void Delete(T* x) 
{
    delete x;
}

// Applies a function/functor to each element in the container.
template <class Container, typename Functor>
void ForEach(const Container& c, Functor functor) 
{
    for_each(c.begin(), c.end(), functor);
}

//Base Person Info
class BasicPersonalInfo
{
public:
    BasicPersonalInfo() {};
    BasicPersonalInfo(string name, int age, string sex) : _name(name), _age(age), _sex(sex) {};
public:
    SET_ATTRIBUTE_IMPL(string, name);
    SET_ATTRIBUTE_IMPL(int, age);
    SET_ATTRIBUTE_IMPL(string, sex);

    GET_ATTRIBUTE_IMPL(string, name);
    GET_ATTRIBUTE_IMPL(int, age);
    GET_ATTRIBUTE_IMPL(string, sex);
private:
    string _name;
    int _age;
    string _sex;
};

//Address Info
class AddressInfo
{
public:
    AddressInfo() {};
    AddressInfo(string bornCity, string workCity) : _bornCity(bornCity), _workCity(workCity) {};
public:
    SET_ATTRIBUTE_IMPL(string, bornCity);
    SET_ATTRIBUTE_IMPL(string, workCity);
    SET_ATTRIBUTE_IMPL(string, postCode);

    GET_ATTRIBUTE_IMPL(string, bornCity);
    GET_ATTRIBUTE_IMPL(string, workCity);
    GET_ATTRIBUTE_IMPL(string, postCode);
private:
    string _bornCity;
    string _workCity;
    string _postCode;
};

// Contact Info
class ContactInfo
{
public:
    ContactInfo() {};
    ContactInfo(string qq, string email, string phoneNumber) : _qq(qq), _email(email), _phoneNumber(phoneNumber) {};
public:
    SET_ATTRIBUTE_IMPL(string, qq);
    SET_ATTRIBUTE_IMPL(string, email);
    SET_ATTRIBUTE_IMPL(string, phoneNumber);

    GET_ATTRIBUTE_IMPL(string, qq);
    GET_ATTRIBUTE_IMPL(string, email);
    GET_ATTRIBUTE_IMPL(string, phoneNumber);
private:
    string _qq;
    string _email;
    string _phoneNumber;
};

// Enducation Exprience Record
class EnducationExprience
{
public:
    EnducationExprience(string school, string period, string major, string enducationBackground):_school(school), \
        _period(period),_major(major), _enducationBackground(enducationBackground) {};
public:
    SET_ATTRIBUTE_IMPL(string, school);
    SET_ATTRIBUTE_IMPL(string, period);
    SET_ATTRIBUTE_IMPL(string, major);
    SET_ATTRIBUTE_IMPL(string, enducationBackground);

    GET_ATTRIBUTE_IMPL(string, school);
    GET_ATTRIBUTE_IMPL(string, period);
    GET_ATTRIBUTE_IMPL(string, major);
    GET_ATTRIBUTE_IMPL(string, enducationBackground);

private:
    string _school;
    string _period;
    string _major;
    string _enducationBackground;
};

// Enducation Info
class EnducationInfo
{
public:
    EnducationInfo() {};
public:
    virtual ~EnducationInfo()
    {
        ForEach(_listEnducationExprience, Delete<EnducationExprience>);
    }
public:
    void addEnducationExperience(EnducationExprience *ee)
    {
        _listEnducationExprience.push_back(ee);
    }
    void delEnducationExperience(EnducationExprience *ee)
    {
        _listEnducationExprience.remove(ee);
    }
    void diplayEnducationInfo(void)
    {
        for (list<EnducationExprience*>::iterator it =  _listEnducationExprience.begin();
            it != _listEnducationExprience.end(); ++it)
        {
            cout << (*it)->GET_ATTRIBUTE_INVOKE(school) << "  ";
            cout << (*it)->GET_ATTRIBUTE_INVOKE(period) << "  ";
            cout << (*it)->GET_ATTRIBUTE_INVOKE(major) << "  ";
            cout << (*it)->GET_ATTRIBUTE_INVOKE(enducationBackground) << endl;
        }
    }
private:
    list<EnducationExprience*> _listEnducationExprience;
};

//Hobby
class Hobby
{
public:
    Hobby() {};
    virtual ~Hobby()
    {
        ForEach(_listHobby, Delete<string>);
    }
public:
    void addHobby(string *hobby)
    {
        _listHobby.push_back(hobby);
    }
    void delHobby(string *hobby)
    {
        _listHobby.remove(hobby);
    }
    void diplayHobby(void)
    {
        for (list<string*>::iterator it = _listHobby.begin();
            it != _listHobby.end(); ++it)
        {
            cout << *(*it) << endl;
        }
    }
private:
    list<string*>  _listHobby;
};

// About Impl
class AboutImpl
{
public:
    AboutImpl()
    {
        initAllPersonalInfo();
    }
public:
    void disPlayAllInfo(void)
    {
        cout << " ***************** About Me Beign ***************** "<< endl;
        displayBasicPersonalInfo();
        displayAddressInfo();
        displayContactInfo();
        displayEnducationInfo();
        displayHobby();
        displayLovedWords();
        cout << " *****************  About Me end  ***************** " << endl;
    }
private:
    void initBasicPersonalInfo(void)
    {
        _basicInfo.SET_ATTRIBUTE_INVOKE(name, "tao ling yang");
        _basicInfo.SET_ATTRIBUTE_INVOKE(age,  27);
        _basicInfo.SET_ATTRIBUTE_INVOKE(sex, "boy");
    }
    void displayBasicPersonalInfo(void)
    {
        cout << "----------------------------" << endl;
        cout << "Basic Personal Information: " << endl;
        cout << "Name: " << _basicInfo.GET_ATTRIBUTE_INVOKE(name) << endl;
        cout << "Age: " << _basicInfo.GET_ATTRIBUTE_INVOKE(age) << endl;
        cout << "Sex: " << _basicInfo.GET_ATTRIBUTE_INVOKE(sex) << endl;
        cout << endl;
    }
    void initAddressInfo(void)
    {
        _addressInfo.SET_ATTRIBUTE_INVOKE(bornCity, "Wuxue, Hubei");
        _addressInfo.SET_ATTRIBUTE_INVOKE(workCity, "Shenzhen, Guangdong");
        _addressInfo.SET_ATTRIBUTE_INVOKE(postCode, "518055");
    }
    void displayAddressInfo(void)
    {
        cout << "----------------------------" << endl;
        cout << "Address Information: " << endl;
        cout << "Born City: " << _addressInfo.GET_ATTRIBUTE_INVOKE(bornCity) << endl;
        cout << "Work City: " << _addressInfo.GET_ATTRIBUTE_INVOKE(workCity) << endl;
        cout << "Post Code: " << _addressInfo.GET_ATTRIBUTE_INVOKE(postCode) << endl;
        cout << endl;
    }
    void initContactInfo(void)
    {
        _contactInfo.SET_ATTRIBUTE_INVOKE(qq, "475168208");
        _contactInfo.SET_ATTRIBUTE_INVOKE(email, "franktly@163.com");
        _contactInfo.SET_ATTRIBUTE_INVOKE(phoneNumber, "18565****87");
    }
    void displayContactInfo(void)
    {
        cout << "----------------------------" << endl;
        cout << "Contact Information: " << endl;
        cout << "QQ: " << _contactInfo.GET_ATTRIBUTE_INVOKE(qq) << endl;
        cout << "Email: " << _contactInfo.GET_ATTRIBUTE_INVOKE(email) << endl;
        cout << "PhoneNumber: " << _contactInfo.GET_ATTRIBUTE_INVOKE(phoneNumber) << endl;
        cout << endl;
    }
    void initEnducationInfo(void)
    {
        EnducationExprience *ee1 = new EnducationExprience("HUST", "2011.09 --> 2014.3", "Mechatronics Enggineering", "Master Engineering(ME)");
        _enducationInfo.addEnducationExperience(ee1);
        EnducationExprience *ee2 = new EnducationExprience("HUST", "2007.09 --> 2011.6", "Mechine design manufacture and automation", "Bachelor Engineering(BE)");
        _enducationInfo.addEnducationExperience(ee2);
    }
    void displayEnducationInfo(void)
    {
        cout << "----------------------------" << endl;
        cout << "Enducation Information: " << endl;
        _enducationInfo.diplayEnducationInfo();
        cout << endl;
    }
    void initHobby(void)
    {
        string *hb1 = new string("New Technology");
        _hobbyInfo.addHobby(hb1);
        string *hb2 = new string("Music");
        _hobbyInfo.addHobby(hb2);
        string *hb3 = new string("Badminton");
        _hobbyInfo.addHobby(hb3);
        string *hb4 = new string("Snooker");
        _hobbyInfo.addHobby(hb4);
        string *hb5 = new string("Film");
        _hobbyInfo.addHobby(hb5);
        string *hb6 = new string("Climbing");
        _hobbyInfo.addHobby(hb6);
    }
    void displayHobby(void)
    {
        cout << "----------------------------" << endl;
        cout << "Hobby Information: " << endl;
        _hobbyInfo.diplayHobby();
        cout << endl;
    }
    void initLovedWords(void)
    {
        _lovedWords.append("Work to work steadfastly, play will play happily\n");
    }
    void displayLovedWords(void)
    {
        cout << "----------------------------" << endl;
        cout << "Love Words: " << endl;
        cout << _lovedWords << endl;
        cout << endl;
    }

    void initAllPersonalInfo(void)
    {
        initBasicPersonalInfo();
        initAddressInfo();
        initContactInfo();
        initEnducationInfo();
        initHobby();
        initLovedWords();
    }
private:
    BasicPersonalInfo _basicInfo;
    AddressInfo _addressInfo;
    ContactInfo _contactInfo;
    EnducationInfo _enducationInfo;
    Hobby  _hobbyInfo;
    string _lovedWords;
};

// About
class About
{
public:
    ~About()
    {
        delete _impl;
    }
    static About* getInstance(void)
    {
        static About about;
        return &about;
    }
    void displayMe(void)
    {
        _impl->disPlayAllInfo();
    }
private:
    AboutImpl *_impl;
private:
    About()
    {
        _impl = new AboutImpl;
    };
    About(const About &about) {};
    About& operator==(const About &about) {};
};

int _tmain(int argc, _TCHAR* argv[])
{
    About::getInstance()->displayMe();
}
```

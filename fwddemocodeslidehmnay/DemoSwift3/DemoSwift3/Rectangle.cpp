//
//  Rectangle.cpp
//  DemoSwift3
//
//  Created by Techmaster on 9/16/16.
//  Copyright © 2016 TechMaster. All rights reserved.
//

#include "Rectangle.hpp"
#include <iostream>
using namespace std;

Rectangle::Rectangle (int x, int y) {
    width=x;
    height=y;
}

int Rectangle::area (void) {
    return (width*height);
}

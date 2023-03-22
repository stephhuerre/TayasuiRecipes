//
//  NSMutableArray+(Sort).h
//  TayasuiRecipes
//
//  Created by steph on 3/21/23.
//

#ifndef NSMutableArray__Sort__h
#define NSMutableArray__Sort__h

#include <stdio.h>
#include <Foundation/Foundation.h>

@class Recipe;

@interface NSMutableArray (Sort)

- (void)sortRecipes;
- (void)insertRecipe:(Recipe*) recipe;

@end

#endif /* NSMutableArray__Sort__h */

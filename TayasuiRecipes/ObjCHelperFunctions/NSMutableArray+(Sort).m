//
//  NSMutableArray+(Sort).c
//  TayasuiRecipes
//
//  Created by steph on 3/21/23.
//

#include "NSMutableArray+(Sort).h"
#import <TayasuiRecipes-Swift.h>

@class Recipe;

@implementation NSMutableArray (Sort)

- (void)sortRecipes {

  NSMutableArray<Recipe *> *sortedRecipes = [[NSMutableArray alloc] initWithCapacity:self.count];
  for (Recipe *recipe in self) {
      [sortedRecipes insertRecipe:recipe];
  }
  [self removeAllObjects];
  [self addObjectsFromArray:sortedRecipes];

}

/* insertRecipe inserts a recipe at the correct index in the array
 the array is an array of recipes sorted in the following order:
 - descending rating
 - descending duration
 - alphabetical name
 time complexity 0(n) */
- (void)insertRecipe:(Recipe *) recipe {

  NSInteger lowIndex = 0;
  NSInteger highIndex = self.count - 1;
  while (lowIndex <= highIndex) {
    NSInteger midIndex = (lowIndex + highIndex) / 2;
    Recipe *currentRecipe = self[midIndex];
    if (currentRecipe.ratingInt > recipe.ratingInt ||
        (currentRecipe.ratingInt == recipe.ratingInt && currentRecipe.durationInMinutes > recipe.durationInMinutes) ||
        (currentRecipe.ratingInt == recipe.ratingInt && currentRecipe.durationInMinutes == recipe.durationInMinutes && [currentRecipe.name compare:recipe.name] == NSOrderedAscending)) {
      lowIndex = midIndex + 1;
    } else {
      highIndex = midIndex - 1;
    }
  }
  [self insertObject:recipe atIndex: lowIndex];

}

// easier to read but greater time complexity
// time complexity 0(n^2)
//- (void)insertRecipe:(Recipe *) recipe {
//    NSInteger i = 0;
//    while (i < self.count) {
//      Recipe *currentRecipe = self[i];
//      if (currentRecipe.rating > recipe.rating) {
//        i++;
//      } else if (currentRecipe.rating == recipe.rating) {
//        if (currentRecipe.durationInMinutes > recipe.durationInMinutes) {
//          i++;
//        } else if (currentRecipe.durationInMinutes == recipe.durationInMinutes) {
//          if ([currentRecipe.name compare:recipe.name] == NSOrderedAscending) { //strcmp(rec[i].name, recipe.name) < 0
//            i++;
//          } else {
//            break;
//          }
//        } else {
//          break;
//        }
//      } else {
//        break;
//      }
//    }
//    [self insertObject:recipe atIndex:i];
//    NSLog(@"insert recipe at index %li", (long)i);
//}

@end

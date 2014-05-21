#import "DPBaseVC.h"

@interface DPBaseVC ()

@end

@implementation DPBaseVC

#pragma mark - Text Field Metods
- (NSString *)valueChangeCharacters:(NSString *)text
                            inRange:(NSRange)range
                  replacementString:(NSString *)string
{
    NSString *value = @"";
    if (range.length == 1){
        value = [text stringByReplacingCharactersInRange:NSMakeRange(text.length - 1, 1)
                                                        withString:@""];
        
    }else{
        value = (text)?:@"";
        value = [text stringByReplacingCharactersInRange:range
                                                        withString:string];
    }
    return value;
}

- (void)animationScrollView:(UIScrollView *)scrollV toPoint:(CGPoint)point
{
    static BOOL isAnimated = NO;
    if (!isAnimated) {
        [UIView animateWithDuration:.35f animations:^{
            [scrollV setContentOffset:point animated:NO];
            isAnimated = YES;
        } completion:^(BOOL finished) {
            isAnimated = NO;
        }];
    }else
        [scrollV setContentOffset:point animated:NO];
}

- (UITextField *)nextFieldAfter:(UITextField *)textField from:(NSArray *)array
{
    NSAssert([array containsObject:textField], @"TextField does not include in textFields collection");
    NSInteger index = [array indexOfObject:textField];
    
    UITextField *nextField;
    if (index + 1 == array.count)
        nextField = array.firstObject;
    else
        nextField = [array objectAtIndex:index + 1];
    
    return nextField;
}
@end

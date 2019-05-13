//
//  ViewController.m
//  算法
//
//  Created by  on 2019/3/26.
//  Copyright © 2019年 . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"算法";
    
    self.dataArr = [NSMutableArray arrayWithObjects:@"冒泡排序",@"C语言快速排序",@"OC快速排序",@"选择排序",@"插入排序",@"二分查找", nil];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}


/**
 冒泡排序
 */
-(void)maopao{
    // 对比相邻的两个元素的大小，如果大于（或者小于）就交换他们的位置
    NSMutableArray *array =[NSMutableArray arrayWithObjects:@89,@35,@56,@2,@45,@33,@27,@74,@14,@8, nil];
    for (int i = 1; i < array.count; i++) {
        for (int j = 0; j < array.count - 1; j++) {
            if ([array[j+1] intValue] < [array[j] intValue]) {
                int temp = [array[j] intValue];
                array[j] = array[j + 1];
                array[j + 1] = [NSNumber numberWithInt:temp];
//                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"冒泡排序%@",array);
}

/**
 C语言快速排序
 */
void sort(int *a, int left, int right)
{
    if(left >= right)/*如果左边索引大于或者等于右边的索引就代表已经整理完成一个组了*/
    {
        return ;
    }
    int i = left;
    int j = right;
    int key = a[left];
    
    while(i < j)                               /*控制在当组内寻找一遍*/
    {
        while(i < j && key <= a[j])
        /*而寻找结束的条件就是，1，找到一个小于或者大于key的数（大于或小于取决于你想升
         序还是降序）2，没有符合条件1的，并且i与j的大小没有反转*/
        {
            j--;/*向前寻找*/
        }
        
        a[i] = a[j];
        /*找到一个这样的数后就把它赋给前面的被拿走的i的值（如果第一次循环且key是
         a[left]，那么就是给key）*/
        
        while(i < j && key >= a[i])
        /*这是i在当组内向前寻找，同上，不过注意与key的大小关系停止循环和上面相反，
         因为排序思想是把数往两边扔，所以左右两边的数大小与key的关系相反*/
        {
            i++;
        }
        
        a[j] = a[i];
    }
    
    a[i] = key;/*当在当组内找完一遍以后就把中间数key回归*/
    sort(a, left, i - 1);/*最后用同样的方式对分出来的左边的小组进行同上的做法*/
    sort(a, i + 1, right);/*用同样的方式对分出来的右边的小组进行同上的做法*/
    /*当然最后可能会出现很多分左右，直到每一组的i = j 为止*/
}


/**
 OC快速排序
 */
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[leftIndex] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}

/**
 选择排序
 */
-(void)xuanzhe{
    // 选择排序
    // 找到最小的元素，放到数组的最前面，重复执行直到结束
    NSMutableArray *array =[NSMutableArray arrayWithObjects:@89,@35,@56,@2,@45,@33,@27,@74,@14,@8, nil];
    for (int i = 0;  i < array.count; i++) {
        for (int j = i + 1; j < array.count; j++) {
            if ([array[i] intValue] > [array[j] intValue]) {
                int temp = [array[i] intValue];
                array[i] = array[j];
                array[j] = [NSNumber numberWithInt:temp];
                //[array exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"选择排序%@",array);
}


/**
 插入排序
 */
-(void)charu{
    // 插入排序
    // 将第一待排序序列第一个元素看做一个有序序列，把第二个元素到最后一个元素当成是未排序序列。
    // 从头到尾依次扫描未排序序列，将扫描到的每个元素插入有序序列的适当位置。
    NSMutableArray *array =[NSMutableArray arrayWithObjects:@89,@35,@56,@2,@45,@33,@27,@74,@14,@8, nil];
    for (int i = 1; i < array.count; i++) {
        int temp = [array[i]intValue];
        for (int j = i - 1; j >= 0 && temp < [array[j]intValue]; j--) {
            array[j+1] = array[j];
            array[j] = [NSNumber numberWithInt:temp];
//            NSLog(@"插入排序%@",array);
        }
    }
    NSLog(@"插入排序%@",array);
}

/**
 二分查找
 */
-(int)binSearch:(NSMutableArray*)array andAllNumber:(int)allNumber andKey:(int)key{
    //在有序表R[0..n-1]中进行二分查找，成功时返回结点的位置，失败时返回-1
    int low=0, high=allNumber, mid;     //置当前查找区间上、下界的初值
    while (low<=high) {
        if([array[low]intValue]==key)
            return low;
        if([array[high]intValue]==key)
            return high;       //当前查找区R[low..high]非空
        mid=low+(high-low)/2;
        /*使用(low+high)/2会有整数溢出的问题
         （问题会出现在当low+high的结果大于表达式结果类型所能表示的最大值时，
         这样，产生溢出后再/2是不会产生正确结果的，而low+((high-low)/2)
         不存在这个问题*/
        if([array[mid]intValue]==key)
            return mid;             //查找成功返回
        else if([array[mid]intValue]<key)
            low=mid+1;              //继续在R[mid+1..high]中查找
        else
            high=mid-1;             //继续在R[low..mid-1]中查找
    }

    return -1;//当low>high时表示所查找区间内没有结果，查找失败
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        [self maopao];
    }
    else if (indexPath.row==1){
        //C语言快速排序
        int number[10] = {12,35,34,67,89,34,12,78,67,89};
        sort(number, 0, 9);
        for (int i =0; i<10; i++) {
            NSLog(@"%d",number[i]);
        }
    }
    else if (indexPath.row==2){
        NSMutableArray *array =[NSMutableArray arrayWithObjects:@15,@45,@67,@5,@26,@99,@67,@14,@35,@9, nil];
        [self quickSortArray:array withLeftIndex:0 andRightIndex:9];
        NSLog(@"%@",array);
    }
    
    else if (indexPath.row==3){
        [self xuanzhe];
    }
    
    else if (indexPath.row==4){
        [self charu];
    }
    else if (indexPath.row==5){
        NSMutableArray *array =[NSMutableArray arrayWithObjects:@8,@15,@26,@32,@45,@53,@67,@74,@84,@91, nil];
        int index = [self binSearch:array andAllNumber:9 andKey:84];
        NSLog(@"%d",index);
    }

}

@end

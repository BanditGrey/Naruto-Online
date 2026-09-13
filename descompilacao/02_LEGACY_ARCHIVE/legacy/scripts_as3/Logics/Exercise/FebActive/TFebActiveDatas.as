package Logics.Exercise.FebActive
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActiveDatas;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TFebActiveDatas extends TBaseActiveDatas
   {
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const ACTIVITY_COUNT:int = 3;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      public var BeginTime:int;
      
      public var EndTime:int;
      
      public var DescList:Vector.<String>;
      
      public var DescListNew:Vector.<String>;
      
      public function TFebActiveDatas()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TFebActive1,TFebActive2,TFebActive3]);
         super(ACTIVITY_COUNT);
         FActivities = new Vector.<TBaseActivity>(ACTIVITY_COUNT);
         _loc1_ = 0;
         while(_loc1_ < ACTIVITY_COUNT)
         {
            _loc2_ = this.DATE_REFERENCE[_loc1_];
            FActivities[_loc1_] = new _loc2_();
            FActivities[_loc1_].Identify = _loc1_ + 1;
            _loc1_++;
         }
         this.DescList = new Vector.<String>();
         this.DescListNew = new Vector.<String>();
      }
      
      override public function ChangeStatus1() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TFebActive1 = null;
         _loc3_ = FActivities[0] as TFebActive1;
         if(_loc3_.DailyGift.Status == TBaseActivity.STATUS_CANGET)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         _loc2_ = int(_loc3_.DailyBox.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_.DailyBox[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc2_ = int(_loc3_.LoginGift.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_.LoginGift[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         _loc2_ = int(_loc3_.SpecialGift.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_.SpecialGift[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus2() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TFebActive2 = null;
         _loc3_ = FActivities[1] as TFebActive2;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus3() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TFebActive3 = null;
         var _loc4_:TActivityTaskData = null;
         var _loc5_:TDessertHouseTask = null;
         var _loc6_:int = 0;
         _loc3_ = FActivities[2] as TFebActive3;
         _loc4_ = SLogicsCore.ActivityTaskData;
         if(_loc4_.NeedShine == TBaseActivity.STATUS_CANGET)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         if(_loc3_.ScoreA > 0)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         if(_loc3_.FirecrackerTime - STimingCore.GetServerTick() < 0)
         {
            return TBaseActivity.STATUS_CANGET;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc4_.TaskList.length)
         {
            _loc5_ = _loc4_.TaskList[_loc1_];
            _loc6_ = _loc5_.Step >= ACT_TASK_STEP ? int(ACT_TASK_STEP - 1) : _loc5_.Step;
            if(_loc5_.Status == TBaseActivity.STATUS_CANGET && _loc5_.Process >= _loc5_.ClientTaskReq[_loc6_])
            {
               return TBaseActivity.STATUS_CANGET;
            }
            _loc1_++;
         }
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      public function InitDescListNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         if(this.DescListNew.length > 0 && Boolean(this.DescListNew[0]))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.DescList.length)
         {
            _loc2_ = int(parseInt(this.DescList[_loc1_]));
            if(TBaseActivity.IsRealNumber(this.DescList[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.DescListNew[_loc1_] = _loc3_;
               }
               else
               {
                  this.DescListNew[_loc1_] = this.DescList[_loc1_];
               }
            }
            else
            {
               this.DescListNew[_loc1_] = this.DescList[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}


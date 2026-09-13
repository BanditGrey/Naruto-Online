package Logics.Exercise.CommonRecharge
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.ConsumeRank.TPerReward;
   import Logics.Exercise.TBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TCommonRecharge extends TBaseActivity
   {
      
      protected var FGotoURL:String;
      
      protected var FTitle:String;
      
      protected var FPicID:int;
      
      protected var FGold:int;
      
      protected var FTabID:Vector.<int>;
      
      protected var FRate:String;
      
      protected var FSingleInventories:Vector.<TPerReward>;
      
      protected var FAccumulateInventories:Vector.<TPerReward>;
      
      protected var FChangeTabIndex:int;
      
      public function TCommonRecharge()
      {
         super();
         this.FTabID = new Vector.<int>();
         this.FSingleInventories = new Vector.<TPerReward>();
         this.FAccumulateInventories = new Vector.<TPerReward>();
      }
      
      public function get SingleInventories() : Vector.<TPerReward>
      {
         return this.FSingleInventories;
      }
      
      public function set SingleInventories(param1:Vector.<TPerReward>) : void
      {
         this.FSingleInventories = param1;
      }
      
      public function get AccumulateInventories() : Vector.<TPerReward>
      {
         return this.FAccumulateInventories;
      }
      
      public function set AccumulateInventories(param1:Vector.<TPerReward>) : void
      {
         this.FAccumulateInventories = param1;
      }
      
      public function get ChangeTabIndex() : int
      {
         return this.FChangeTabIndex;
      }
      
      public function set ChangeTabIndex(param1:int) : void
      {
         this.FChangeTabIndex = param1;
      }
      
      public function get GotoURL() : String
      {
         return this.FGotoURL;
      }
      
      public function set GotoURL(param1:String) : void
      {
         this.FGotoURL = param1;
      }
      
      public function get Title() : String
      {
         return this.FTitle;
      }
      
      public function set Title(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(this.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FTitle = _loc3_;
            }
         }
         else
         {
            this.FTitle = param1;
         }
      }
      
      public function get Gold() : int
      {
         return this.FGold;
      }
      
      public function set Gold(param1:int) : void
      {
         this.FGold = param1;
      }
      
      public function get TabID() : Vector.<int>
      {
         return this.FTabID;
      }
      
      public function set TabID(param1:Vector.<int>) : void
      {
         this.FTabID = param1;
      }
      
      public function get PicID() : int
      {
         return this.FPicID;
      }
      
      public function set PicID(param1:int) : void
      {
         this.FPicID = param1;
      }
      
      public function get Rate() : String
      {
         return this.FRate;
      }
      
      public function set Rate(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(this.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FRate = _loc3_;
            }
         }
         else
         {
            this.FRate = param1;
         }
      }
      
      public function IsRealNumber(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if((param1.charCodeAt(_loc2_) > 57 || param1.charCodeAt(_loc2_) < 48) && param1.charCodeAt(_loc2_) != 46)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
   }
}


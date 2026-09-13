package Logics.Wing
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TWingAdvanced;
   import Logics.Exercise.TBaseBox;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TWing
   {
      
      public static const TYPE_FREE:int = 0;
      
      public static const TYPE_GOLD:int = 1;
      
      public static const TYPE_AUTO:int = 2;
      
      public var WingID:int;
      
      public var CurExp:int;
      
      public var StrengthenConfig:Vector.<TBaseBox>;
      
      public var TransformID:int;
      
      public var TransformTime:int;
      
      public var HideWing:int;
      
      public var BaseWings:Vector.<TWingAdvanced>;
      
      public var SpeicalWings:Vector.<TWingAdvanced>;
      
      public var TrialCampaignList:Vector.<TTrialCampaign>;
      
      public var ColorfulFeather:int;
      
      public var Stone:int;
      
      public var JihuoCnt:int;
      
      public var TransformWings:Vector.<TBaseBox>;
      
      public function TWing()
      {
         super();
         this.StrengthenConfig = new Vector.<TBaseBox>();
         this.BaseWings = new Vector.<TWingAdvanced>();
         this.SpeicalWings = new Vector.<TWingAdvanced>();
         this.HideWing = 2;
         this.TrialCampaignList = new Vector.<TTrialCampaign>();
         this.TransformWings = new Vector.<TBaseBox>();
      }
      
      public function UpdateWings() : void
      {
         var _loc1_:TBins = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TWingAdvanced = null;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WingAdvanced);
         if(_loc1_)
         {
            this.BaseWings.length = 0;
            this.SpeicalWings.length = 0;
            _loc3_ = _loc1_.Count;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = _loc1_.GetDatebaseByIndex(_loc2_) as TWingAdvanced;
               if(_loc4_.illusionType == 1)
               {
                  this.BaseWings.push(_loc4_);
               }
               else
               {
                  this.SpeicalWings.push(_loc4_);
               }
               _loc2_++;
            }
         }
      }
      
      public function get CoinPrice() : int
      {
         return this.StrengthenConfig[TYPE_FREE].Price;
      }
      
      public function set CoinPrice(param1:int) : void
      {
         this.StrengthenConfig[TYPE_FREE].Price = param1;
      }
      
      public function get GoldPrice() : int
      {
         return this.StrengthenConfig[TYPE_GOLD].Price;
      }
      
      public function set GoldPrice(param1:int) : void
      {
         this.StrengthenConfig[TYPE_GOLD].Price = param1;
      }
      
      public function get AutoPrice() : int
      {
         return this.StrengthenConfig[TYPE_AUTO].Price;
      }
      
      public function set AutoPrice(param1:int) : void
      {
         this.StrengthenConfig[TYPE_AUTO].Price = param1;
      }
      
      public function get CoinCount() : int
      {
         return this.StrengthenConfig[TYPE_FREE].Count;
      }
      
      public function set CoinCount(param1:int) : void
      {
         this.StrengthenConfig[TYPE_FREE].Count = param1;
      }
      
      public function get GoldCount() : int
      {
         return this.StrengthenConfig[TYPE_GOLD].Count;
      }
      
      public function set GoldCount(param1:int) : void
      {
         this.StrengthenConfig[TYPE_GOLD].Count = param1;
      }
      
      public function get AutoCount() : int
      {
         return this.StrengthenConfig[TYPE_AUTO].Count;
      }
      
      public function set AutoCount(param1:int) : void
      {
         this.StrengthenConfig[TYPE_AUTO].Count = param1;
      }
      
      public function get GoldCrit() : int
      {
         return this.StrengthenConfig[TYPE_GOLD].Min;
      }
      
      public function set GoldCrit(param1:int) : void
      {
         this.StrengthenConfig[TYPE_GOLD].Min = param1;
      }
      
      public function get AutoCrit() : int
      {
         return this.StrengthenConfig[TYPE_AUTO].Min;
      }
      
      public function set AutoCrit(param1:int) : void
      {
         this.StrengthenConfig[TYPE_AUTO].Min = param1;
      }
      
      public function get GoldBigCrit() : int
      {
         return this.StrengthenConfig[TYPE_GOLD].Max;
      }
      
      public function set GoldBigCrit(param1:int) : void
      {
         this.StrengthenConfig[TYPE_GOLD].Min = param1;
      }
      
      public function get AutoBigCrit() : int
      {
         return this.StrengthenConfig[TYPE_AUTO].Max;
      }
      
      public function set AutoBigCrit(param1:int) : void
      {
         this.StrengthenConfig[TYPE_AUTO].Max = param1;
      }
      
      public function get CoinExp() : int
      {
         return this.StrengthenConfig[TYPE_FREE].Level;
      }
      
      public function set CoinExp(param1:int) : void
      {
         this.StrengthenConfig[TYPE_FREE].Level = param1;
      }
      
      public function get GoldExp() : int
      {
         return this.StrengthenConfig[TYPE_GOLD].Level;
      }
      
      public function set GoldExp(param1:int) : void
      {
         this.StrengthenConfig[TYPE_GOLD].Level = param1;
      }
      
      public function get AutoExp() : int
      {
         return this.StrengthenConfig[TYPE_AUTO].Level;
      }
      
      public function set AutoExp(param1:int) : void
      {
         this.StrengthenConfig[TYPE_AUTO].Level = param1;
      }
      
      public function get CurTransformWing() : TWingAdvanced
      {
         var _loc1_:TBins = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TWingAdvanced = null;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WingAdvanced);
         return _loc1_.GetDatebaseByIdentifier(this.TransformID) as TWingAdvanced;
      }
      
      public function AddTrialCampaign(param1:TTrialCampaign) : void
      {
         this.TrialCampaignList.push(param1);
      }
      
      public function GetTrialCampaignByCampaignId(param1:uint) : TTrialCampaign
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTrialCampaign = null;
         _loc2_ = 0;
         while(_loc2_ < this.TrialCampaignList.length)
         {
            _loc4_ = this.TrialCampaignList[_loc2_];
            if(_loc4_.CampaignId == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetTrialCampaignByIndex(param1:int) : TTrialCampaign
      {
         return this.TrialCampaignList[param1];
      }
      
      public function GetWingTransformTimeByID(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.TransformWings.length)
         {
            if(param1 == this.TransformWings[_loc2_].Identify)
            {
               return this.TransformWings[_loc2_].Time;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function ChangeWingTransformTimeByID(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         _loc3_ = 0;
         while(_loc3_ < this.TransformWings.length)
         {
            if(param1 == this.TransformWings[_loc3_].Identify)
            {
               this.TransformWings[_loc3_].Time = param2;
               return;
            }
            _loc3_++;
         }
         _loc4_ = new TBaseBox();
         _loc4_.Identify = param1;
         _loc4_.Time = param2;
         this.TransformWings.push(_loc4_);
      }
      
      public function GetWingTransformCountByID(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.TransformWings.length)
         {
            if(param1 == this.TransformWings[_loc2_].Identify)
            {
               return this.TransformWings[_loc2_].TotalTms;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function ChangeWingTransformCountByID(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         if(param2 == -1)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < this.TransformWings.length)
         {
            if(param1 == this.TransformWings[_loc3_].Identify)
            {
               this.TransformWings[_loc3_].TotalTms = param2;
               return;
            }
            _loc3_++;
         }
         _loc4_ = new TBaseBox();
         _loc4_.Identify = param1;
         _loc4_.TotalTms = param2;
         this.TransformWings.push(_loc4_);
      }
   }
}


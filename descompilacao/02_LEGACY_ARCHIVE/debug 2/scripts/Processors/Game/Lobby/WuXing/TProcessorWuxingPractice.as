package Processors.Game.Lobby.WuXing
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TWuxingConfig;
   import Logics.DatebaseVO.VO.TWuxingUpgrade;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.WuXing.TWuXing;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_WUXING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWuxingPractice extends TProcessorLobbyWindow
   {
      
      protected var FMCWuxingPractice:MovieClip;
      
      protected var FMCElementList:Array = new Array();
      
      protected var FBtnList:Array = new Array();
      
      protected var FTFItemList:Array = new Array();
      
      protected const ELE_TYPE:Array = CONST_WUXING.ELE_TYPE;
      
      protected var FCostObjVector:Vector.<Object>;
      
      protected var FTFLevelList:Array = new Array();
      
      protected var FTFExpList:Array = new Array();
      
      public var OnLevelupClick:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      protected var FWuxingConfigBins:TBins;
      
      public var SynchronWuxingLevel:Function;
      
      public function TProcessorWuxingPractice(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function Initiliation() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc3_:TextField = null;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         var _loc8_:TConfigValue = null;
         this.FMCWuxingPractice = TProcessorWuxing(FParent).MC_WuxingPractice;
         _loc7_ = 1;
         while(_loc7_ < this.ELE_TYPE.length)
         {
            _loc1_ = this.FMCWuxingPractice["MC_" + this.ELE_TYPE[_loc7_]];
            this.FMCElementList.push(_loc1_);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.OnUIComponentOut,false,0,true);
            _loc1_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnUIComponentMove,false,0,true);
            _loc2_ = this.FMCWuxingPractice["Btn_levelup_" + _loc7_];
            TGameUtil.setButtonMode(_loc2_,true);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onLevelUpHandler);
            _loc3_ = this.FMCWuxingPractice["TF_costItem" + _loc7_];
            this.FTFItemList.push(_loc3_);
            _loc4_ = this.FMCWuxingPractice["TF_Exp_" + _loc7_];
            _loc4_.mouseEnabled = false;
            _loc5_ = this.FMCWuxingPractice["TF_Lv_" + _loc7_];
            this.FTFLevelList.push(_loc5_);
            _loc5_.mouseEnabled = false;
            _loc6_ = this.FMCWuxingPractice["MC_Exp_" + _loc7_];
            _loc6_.mouseEnabled = false;
            _loc7_++;
         }
         _loc8_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,93000001) as TConfigValue;
         this.FCostObjVector = _loc8_.Value as Vector.<Object>;
         this.FWuxingConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WuxingConfig);
      }
      
      public function UpdateInterface(param1:Vector.<TWuXing>) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:int = 0;
         var _loc4_:TWuXing = null;
         var _loc5_:TextField = null;
         var _loc6_:TWuxingUpgrade = null;
         var _loc7_:MovieClip = null;
         if(param1)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc4_ = param1[_loc3_] as TWuXing;
               _loc6_ = this.getCurWuxingUpgradeByExp(_loc4_.Exp);
               _loc2_ = this.FMCWuxingPractice["TF_Exp_" + (_loc3_ + 1)];
               _loc2_.text = _loc4_.Exp - _loc6_.AllExp + "\n/\n" + _loc6_.NeedExp;
               _loc5_ = this.FMCWuxingPractice["TF_Lv_" + (_loc3_ + 1)];
               _loc5_.text = "LV " + _loc6_.Level;
               _loc7_ = this.FMCWuxingPractice["MC_Exp_" + (_loc3_ + 1)];
               _loc7_.scaleY = (_loc4_.Exp - _loc6_.AllExp) / _loc6_.NeedExp;
               this.SynchronWuxingLevel(_loc6_.Level,_loc3_);
               _loc3_++;
            }
         }
         this.updateCostItemNum();
      }
      
      protected function onLevelUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.target.name.substr(-1));
         if(this.OnLevelupClick != null)
         {
            this.OnLevelupClick(_loc2_);
         }
      }
      
      protected function updateCostItemNum() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:Object = null;
         _loc1_ = 0;
         while(_loc1_ < this.FTFItemList.length)
         {
            _loc3_ = this.FCostObjVector[_loc1_];
            TextField(this.FTFItemList[_loc1_]).text = this.getInventoryById(_loc3_[1]);
            _loc1_++;
         }
      }
      
      protected function getInventoryById(param1:int) : String
      {
         var _loc2_:TArticle = null;
         var _loc3_:TInventories = null;
         _loc3_ = SLogicsCore.Character.Appliances;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1) as TArticle;
         return _loc2_.Name + "*" + _loc3_.GetAllCountByTempletID(param1);
      }
      
      protected function getCurWuxingUpgradeByExp(param1:int) : TWuxingUpgrade
      {
         var FWuxingUpgrade:TWuxingUpgrade = null;
         var FNextWuxingUpgrade:TWuxingUpgrade = null;
         var FWuxingBins:TBins = null;
         var Index:int = 0;
         var Level:int = 0;
         var Exp:int = param1;
         FWuxingBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_WuxingUpgrade) as TBins;
         Index = 0;
         while(Index < FWuxingBins.Count)
         {
            FWuxingUpgrade = FWuxingBins.GetDatebaseByIndex(Index) as TWuxingUpgrade;
            try
            {
               FNextWuxingUpgrade = FWuxingBins.GetDatebaseByIndex(Index + 1) as TWuxingUpgrade;
            }
            catch(e:Error)
            {
               FNextWuxingUpgrade = FWuxingUpgrade;
            }
            if(Exp >= FWuxingUpgrade.AllExp && Exp < FNextWuxingUpgrade.AllExp)
            {
               return FWuxingUpgrade;
            }
            Index++;
         }
         return FNextWuxingUpgrade;
      }
      
      protected function OnUIComponentMove(param1:MouseEvent) : void
      {
         var _loc2_:TWuxingConfig = null;
         var _loc3_:TWuxingConfig = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = this.FMCElementList.indexOf(param1.target);
         _loc5_ = int(this.FTFLevelList[_loc4_].text.substr(2));
         _loc2_ = this.FWuxingConfigBins.GetDatebaseByValue2("Type",_loc4_ + 1,"Level",_loc5_) as TWuxingConfig;
         _loc3_ = this.FWuxingConfigBins.GetDatebaseByValue2("Type",_loc4_ + 1,"Level",_loc5_ + 1) as TWuxingConfig;
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(this,_loc2_,_loc3_);
         }
      }
      
      protected function OnUIComponentOut(param1:MouseEvent) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(this);
         }
      }
      
      public function get UIComponentsHintOnOver() : Function
      {
         return this.FUIComponentsHintOnOver;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function get UIComponentsHintOnOut() : Function
      {
         return this.FUIComponentsHintOnOut;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
   }
}


package Processors.Game.Lobby.BloodSoulPurgatory
{
   import Foundation.Utilities.TGameUtil;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class AlonePopFrame
   {
      
      protected var FAlonePanel:MovieClip;
      
      protected var FMc_SilverCoinPractice:MovieClip;
      
      protected var FTF_Core_count:TextField;
      
      protected var FTF_Jade_name:TextField;
      
      protected var FTF_Jade_Count:TextField;
      
      protected var FMc_GoldPractice:MovieClip;
      
      protected var FMc_AdvancedPractice:MovieClip;
      
      protected var FFreeSilverCount:int;
      
      protected var FCurSilverCount:int;
      
      protected var FIsSilverCanClick:Boolean = true;
      
      protected var FGoldTimes:int;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FBooldType:int;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FIsCanUse:Boolean;
      
      protected var FReason01:Boolean;
      
      protected var FReason02:Boolean;
      
      protected var FSourId:int;
      
      protected var FBtnBackFunc:Function;
      
      protected var FBtnOverBackFunc:Function;
      
      protected var FBtnMoveBackFunc:Function;
      
      protected var FBtnOutBackFunc:Function;
      
      protected var FRootOutBackFunc:Function;
      
      public function AlonePopFrame()
      {
         super();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>(1);
      }
      
      public function setRootPanel(param1:MovieClip) : void
      {
         this.FAlonePanel = param1;
         this.initili();
      }
      
      public function initili() : void
      {
         if(!this.FAlonePanel)
         {
            return;
         }
         this.FMc_SilverCoinPractice = this.FAlonePanel[CONST_BLOODPURGATORY.BooldPurgatory_Mc_SilverCoinPractice];
         this.FTF_Core_count = this.FAlonePanel[CONST_BLOODPURGATORY.BooldPurgatory_TF_Core_count];
         this.FTF_Jade_name = this.FAlonePanel[CONST_BLOODPURGATORY.BooldPurgatory_FTF_Jade_name];
         this.FTF_Jade_Count = this.FAlonePanel[CONST_BLOODPURGATORY.BooldPurgatory_TF_Jade_Count];
         this.FMc_GoldPractice = this.FAlonePanel[CONST_BLOODPURGATORY.BooldPurgatory_Mc_GoldPractice];
         this.FMc_AdvancedPractice = this.FAlonePanel[CONST_BLOODPURGATORY.BooldPurgatory_Mc_AdvancedPractice];
         TGameUtil.setButtonMode(this.FMc_SilverCoinPractice,true);
         TGameUtil.setButtonMode(this.FMc_GoldPractice,true);
         TGameUtil.setButtonMode(this.FMc_AdvancedPractice,true);
         this.addEventListener();
      }
      
      public function SetSilverCount(param1:int) : void
      {
         this.FCurSilverCount = param1;
         this.RefleshSilverBtn();
         this.FTF_Core_count.text = this.FCurSilverCount + "/" + this.FFreeSilverCount;
      }
      
      public function RefleshSilverBtn() : void
      {
         if(this.FCurSilverCount >= this.FFreeSilverCount)
         {
            this.FCurSilverCount = this.FFreeSilverCount;
            this.FMc_SilverCoinPractice.filters = [TGameUtil.gBlackFilters];
            this.FIsSilverCanClick = false;
         }
         else
         {
            this.FMc_SilverCoinPractice.filters = [];
            this.FIsSilverCanClick = true;
         }
      }
      
      protected function addEventListener() : void
      {
         this.FAlonePanel.addEventListener(MouseEvent.MOUSE_OUT,this.FRootOutBackFuncF);
         this.AddEventLitener(this.FMc_SilverCoinPractice);
         this.AddEventLitener(this.FMc_GoldPractice);
         this.AddEventLitener(this.FMc_AdvancedPractice);
      }
      
      public function AddEventLitener(param1:MovieClip) : void
      {
         param1.addEventListener(MouseEvent.CLICK,this.PracticeClickBtn);
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.PracticeOverBtn);
         param1.addEventListener(MouseEvent.MOUSE_MOVE,this.PracticeMoveBtn);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.PracticeOutBtn);
      }
      
      public function PracticeClickBtn(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(SLogicsCore.Character.MaxTempValue)
         {
            return;
         }
         switch(param1.currentTarget)
         {
            case this.FMc_SilverCoinPractice:
               if(!this.FIsSilverCanClick)
               {
                  return;
               }
               _loc2_ = 1;
               break;
            case this.FMc_GoldPractice:
               _loc2_ = 2;
               break;
            case this.FMc_AdvancedPractice:
               _loc2_ = 3;
         }
         if(this.FBtnBackFunc != null)
         {
            this.FBtnBackFunc(this,_loc2_);
         }
      }
      
      public function PracticeOverBtn(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FMc_SilverCoinPractice:
               _loc2_ = 1;
               break;
            case this.FMc_GoldPractice:
               _loc2_ = 2;
               break;
            case this.FMc_AdvancedPractice:
               _loc2_ = 3;
         }
         if(this.FBtnOverBackFunc != null)
         {
            this.FBtnOverBackFunc(_loc2_,this.FGoldTimes,this.FBooldType);
         }
      }
      
      public function PracticeMoveBtn(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FMc_SilverCoinPractice:
               _loc2_ = 1;
               break;
            case this.FMc_GoldPractice:
               _loc2_ = 2;
               break;
            case this.FMc_AdvancedPractice:
               _loc2_ = 3;
         }
         if(this.FBtnMoveBackFunc != null)
         {
            this.FBtnMoveBackFunc(_loc2_,this.FGoldTimes);
         }
      }
      
      public function PracticeOutBtn(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FMc_SilverCoinPractice:
               _loc2_ = 1;
               break;
            case this.FMc_GoldPractice:
               _loc2_ = 2;
               break;
            case this.FMc_AdvancedPractice:
               _loc2_ = 3;
         }
         if(this.FBtnOutBackFunc != null)
         {
            this.FBtnOutBackFunc(_loc2_,this.FGoldTimes);
         }
      }
      
      public function FRootOutBackFuncF(param1:MouseEvent) : void
      {
         this.FRootOutBackFunc();
      }
      
      public function set Mc_SilverCoinPractice(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FMc_SilverCoinPractice,param1);
      }
      
      public function set Mc_GoldPractice(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FMc_GoldPractice,param1);
      }
      
      public function set Mc_AdvancedPractice(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FMc_AdvancedPractice,param1);
      }
      
      public function set BtnBackFunc(param1:Function) : void
      {
         this.FBtnBackFunc = param1;
      }
      
      public function set BtnOverBackFunc(param1:Function) : void
      {
         this.FBtnOverBackFunc = param1;
      }
      
      public function set BtnMoveBackFunc(param1:Function) : void
      {
         this.FBtnMoveBackFunc = param1;
      }
      
      public function set BtnOutBackFunc(param1:Function) : void
      {
         this.FBtnOutBackFunc = param1;
      }
      
      public function set RootOutBackFunc(param1:Function) : void
      {
         this.FRootOutBackFunc = param1;
      }
      
      public function SetFilters(param1:Boolean) : void
      {
         if(this.FAlonePanel == null)
         {
            return;
         }
         if(param1)
         {
            this.FAlonePanel.parent.filters = [TGameUtil.gBlackFilters];
         }
         else
         {
            this.FAlonePanel.parent.filters = [];
            this.RefleshSilverBtn();
         }
      }
      
      public function set IsCanUse(param1:Boolean) : void
      {
         this.FIsCanUse = param1;
      }
      
      public function set Reason01(param1:Boolean) : void
      {
         this.FReason01 = param1;
      }
      
      public function get Reason01() : Boolean
      {
         return this.FReason01;
      }
      
      public function set Reason02(param1:Boolean) : void
      {
         this.FReason02 = param1;
      }
      
      public function get IsCanUse() : Boolean
      {
         return this.FIsCanUse;
      }
      
      public function set FreeSilverCount(param1:int) : void
      {
         this.FFreeSilverCount = param1;
      }
      
      public function set SourId(param1:int) : void
      {
         this.FSourId = param1;
      }
      
      public function get GoldTimes() : int
      {
         return this.FGoldTimes;
      }
      
      public function set GoldTimes(param1:int) : void
      {
         this.FGoldTimes = param1;
      }
      
      public function get BooldType() : int
      {
         return this.FBooldType;
      }
      
      public function set BooldType(param1:int) : void
      {
         this.FBooldType = param1;
      }
      
      public function set StuffShow(param1:int) : void
      {
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId[0] = param1;
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
      }
      
      public function UpdataStuffCount() : void
      {
         var _loc1_:int = this.FSelectInventories.Count;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:TInventory = this.FSelectInventories.GetInventoryByIndex(0);
         this.FTF_Jade_name.text = _loc2_.Name;
         this.FTF_Jade_Count.text = String(this.getInventoryById(_loc2_));
      }
      
      protected function getInventoryById(param1:TInventory) : int
      {
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         return _loc2_.GetAllCountByTempletID(param1.IDTemplate);
      }
   }
}


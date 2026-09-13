package Processors.Game.Lobby.TheWorldTree.BigPanel
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Tools.MvcPlayEffect;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TGodtreeConfig;
   import Logics.DatebaseVO.VO.TGodtreeDrop;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.TheWorldTree.TTheWorldTreeLogicData;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_THEWORLDTREE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TMC_CanWuQian
   {
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      public static const SLOT_COUNT:int = 6;
      
      public static const MAX_LEVEL:int = 100;
      
      protected var FThisPanel:MovieClip;
      
      protected var FMC_BeginCanWuBtn:SimpleButton;
      
      protected var FMC_LittleRain:MovieClip;
      
      protected var FMC_LittleRainCopy:MovieClip;
      
      protected var FTF_LittleRainDec:TextField;
      
      protected var FMC_BigRain:MovieClip;
      
      protected var FMC_BigRainCopy:MovieClip;
      
      protected var FTF_BigRainDec:TextField;
      
      protected var FTF_TheWorldLevelDec:TextField;
      
      protected var FMC_Bar:MovieClip;
      
      protected var FTF_EXP:TextField;
      
      protected var FMC_SlotArea1:MovieClip;
      
      protected var FMC_FullListBtn:MovieClip;
      
      protected var FTF_OneMinuteBaseExp:TextField;
      
      protected var FTF_OneMinuteBaseEnergy:TextField;
      
      protected var FMC_SlotArea2:MovieClip;
      
      protected var FBTN_Left:MovieClip;
      
      protected var FBTN_Right:MovieClip;
      
      protected var FMvcPlayEffect:MvcPlayEffect;
      
      protected var FCurBins:TBins;
      
      protected var FCurBinsCopy:TBins;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FTempSelectInventoriesCount:Vector.<uint>;
      
      protected var FLogicDate:TTheWorldTreeLogicData;
      
      protected var CurPageIndex:int;
      
      protected var FUpdateFiveSlot:Function;
      
      protected var FBackFunction:Function;
      
      protected var FGlowsFilter:TEffectBaseGlowTwo;
      
      protected var CurBtnType:int;
      
      public function TMC_CanWuQian(param1:TTheWorldTreeLogicData)
      {
         super();
         this.FLogicDate = param1;
         this.FMvcPlayEffect = new MvcPlayEffect(this.EffectPlayOver,25);
      }
      
      public function set ThisPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.Initilization();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FTempSelectInventoriesCount = new Vector.<uint>();
         this.FCurBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GodtreeConfig);
         this.FCurBinsCopy = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GodtreeDro);
      }
      
      protected function Initilization() : void
      {
         var _loc1_:int = 0;
         this.FMC_LittleRain = this.FThisPanel["MC_LittleRain"];
         this.FMC_LittleRainCopy = this.FThisPanel["MC_LittleRainCopy"];
         this.FMC_LittleRainCopy.buttonMode = false;
         this.FMC_LittleRainCopy.mouseEnabled = false;
         this.FTF_LittleRainDec = this.FThisPanel["TF_LittleRainDec"];
         this.FMC_BigRain = this.FThisPanel["MC_BigRain"];
         this.FMC_BigRainCopy = this.FThisPanel["MC_BigRainCopy"];
         this.FMC_BigRainCopy.buttonMode = false;
         this.FMC_BigRainCopy.mouseEnabled = false;
         this.FTF_BigRainDec = this.FThisPanel["TF_BigRainDec"];
         this.FTF_TheWorldLevelDec = this.FThisPanel["TF_TheWorldLevelDec"];
         this.FMC_BeginCanWuBtn = this.FThisPanel["MC_BeginCanWuBtn"];
         this.FMC_Bar = this.FThisPanel["MC_Bar"];
         this.FTF_EXP = this.FThisPanel["TF_EXP"];
         this.FMC_SlotArea1 = this.FThisPanel["MC_SlotArea"];
         this.FMC_FullListBtn = this.FMC_SlotArea1["MC_FullListBtn"];
         this.FTF_OneMinuteBaseExp = this.FMC_SlotArea1["TF_OneMinuteBaseExp"];
         this.FTF_OneMinuteBaseEnergy = this.FMC_SlotArea1["TF_OneMinuteBaseEnergy"];
         this.FMC_SlotArea2 = this.FMC_SlotArea1["MC_SlotArea"];
         this.FBTN_Left = this.FMC_SlotArea2["BTN_Left"];
         this.FBTN_Right = this.FMC_SlotArea2["BTN_Right"];
         TGameUtil.setButtonMode(this.FMC_FullListBtn,true);
         this.FGlowsFilter = new TEffectBaseGlowTwo();
         this.FGlowsFilter.SetParameters(this.FMC_FullListBtn,FilterColor,FilterGlowWidth,FilterGlowStrength);
         this.SetEffectBtnState(true);
      }
      
      public function AddEvent() : void
      {
         this.FBTN_Left.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FBTN_Right.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_FullListBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_LittleRain.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_BigRain.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_BeginCanWuBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBTN_Left:
               if(!this.FBTN_Left.buttonMode)
               {
                  return;
               }
               --this.CurPageIndex;
               this.UpdatePageByIndex();
               break;
            case this.FBTN_Right:
               if(!this.FBTN_Right.buttonMode)
               {
                  return;
               }
               ++this.CurPageIndex;
               this.UpdatePageByIndex();
               break;
            case this.FMC_FullListBtn:
               this.FBackFunction(3);
               break;
            case this.FMC_LittleRain:
               if(!this.FMC_LittleRain.buttonMode)
               {
                  return;
               }
               this.CurBtnType = 1;
               this.FBackFunction(1);
               break;
            case this.FMC_BigRain:
               if(!this.FMC_BigRain.buttonMode)
               {
                  return;
               }
               this.CurBtnType = 2;
               this.FBackFunction(2);
               break;
            case this.FMC_BeginCanWuBtn:
               this.FBackFunction(0);
         }
      }
      
      public function NowPlayeEffect() : void
      {
         this.SetEffectBtnState(false);
         if(this.CurBtnType == 1)
         {
            this.FMvcPlayEffect.CurFream = 25;
            this.FMvcPlayEffect.SetEffectPanel(this.FMC_LittleRainCopy);
         }
         else
         {
            this.FMvcPlayEffect.CurFream = 30;
            this.FMvcPlayEffect.SetEffectPanel(this.FMC_BigRainCopy);
         }
         this.FMvcPlayEffect.playEffect();
      }
      
      protected function SetEffectBtnState(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC_LittleRain.visible = param1;
            this.FMC_BigRain.visible = param1;
            this.FMC_LittleRainCopy.visible = !param1;
            this.FMC_BigRainCopy.visible = !param1;
         }
         else
         {
            if(this.CurBtnType == 1 && this.FMC_LittleRain.buttonMode)
            {
               this.FMC_LittleRainCopy.gotoAndStop(1);
               this.FMC_LittleRainCopy.visible = !param1;
               this.FMC_LittleRain.visible = param1;
            }
            if(this.CurBtnType == 2 && this.FMC_BigRain.buttonMode)
            {
               this.FMC_BigRainCopy.gotoAndStop(1);
               this.FMC_BigRainCopy.visible = !param1;
               this.FMC_BigRain.visible = param1;
            }
         }
         if(SLogicsCore.TheWorldTreeLogicData.TheWorldTreeCurLevel == MAX_LEVEL)
         {
            this.FMC_BigRainCopy.visible = false;
            this.FMC_BigRain.visible = false;
            this.FTF_BigRainDec.visible = false;
            this.FMC_LittleRainCopy.visible = false;
            this.FMC_LittleRain.visible = false;
            this.FTF_LittleRainDec.visible = false;
         }
      }
      
      protected function EffectPlayOver() : void
      {
         this.SetEffectBtnState(true);
      }
      
      protected function UpdatePageByIndex() : void
      {
         var _loc1_:Boolean = false;
         if(this.CurPageIndex <= 0)
         {
            this.CurPageIndex = 0;
            _loc1_ = false;
         }
         else
         {
            _loc1_ = true;
         }
         TGameUtil.setButtonMode(this.FBTN_Left,_loc1_);
         var _loc2_:int = this.FSelectInventories.Count / SLOT_COUNT;
         if(this.CurPageIndex >= _loc2_)
         {
            this.CurPageIndex = _loc2_;
            _loc1_ = false;
         }
         else
         {
            _loc1_ = true;
         }
         TGameUtil.setButtonMode(this.FBTN_Right,_loc1_);
         this.UpdateInventory();
         this.FUpdateFiveSlot(this.FSelectInventories,this.CurPageIndex);
      }
      
      public function LogicsPerform() : void
      {
         if(this.FGlowsFilter == null)
         {
            return;
         }
         if(!this.FGlowsFilter.IsRunOver)
         {
            this.FGlowsFilter.Run();
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:TGodtreeConfig = null;
         _loc2_ = this.FCurBins.GetDatebaseByIdentifier(11800000 + this.FLogicDate.TheWorldTreeCurLevel) as TGodtreeConfig;
         this.FTF_OneMinuteBaseExp.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str6).DescribeString,_loc2_.GainExp);
         this.FTF_OneMinuteBaseEnergy.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str7).DescribeString,_loc2_.GainMana);
         this.FTF_LittleRainDec.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str4).DescribeString,this.FLogicDate.TheWorldTreeWateringCount,this.FLogicDate.WateringCountCost.length);
         this.FTF_BigRainDec.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str4).DescribeString,this.FLogicDate.TheWorldTreeRainCount,this.FLogicDate.RainCountCost.length);
         this.FLogicDate.AddExpOneTime = _loc2_.GainExp;
         this.FLogicDate.AddPowerOneTime = _loc2_.GainMana;
         if(this.FLogicDate.TheWorldTreeWateringCount >= this.FLogicDate.WateringCountCost.length)
         {
            _loc1_ = false;
         }
         else
         {
            _loc1_ = true;
         }
         TGameUtil.setButtonMode(this.FMC_LittleRain,_loc1_);
         if(this.FLogicDate.TheWorldTreeRainCount >= this.FLogicDate.RainCountCost.length)
         {
            _loc1_ = false;
         }
         else
         {
            _loc1_ = true;
         }
         TGameUtil.setButtonMode(this.FMC_BigRain,_loc1_);
         this.FTF_TheWorldLevelDec.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str5).DescribeString,this.FLogicDate.TheWorldTreeCurLevel);
         this.FTF_EXP.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str4).DescribeString,this.FLogicDate.TheWorldTreeCurExp,_loc2_.CostMana);
         this.FMC_Bar.scaleX = this.FLogicDate.TheWorldTreeCurExp / _loc2_.CostMana;
         this.CurPageIndex = 0;
         this.UpdatePageByIndex();
         if(this.CheckGift())
         {
            this.FGlowsFilter.IsRunOver = false;
         }
         else
         {
            this.FGlowsFilter.Stop();
         }
         if(SLogicsCore.TheWorldTreeLogicData.TheWorldTreeCurLevel == MAX_LEVEL)
         {
            this.FMC_BigRainCopy.visible = false;
            this.FMC_BigRain.visible = false;
            this.FTF_BigRainDec.visible = false;
            this.FMC_LittleRainCopy.visible = false;
            this.FMC_LittleRain.visible = false;
            this.FTF_LittleRainDec.visible = false;
         }
      }
      
      protected function CheckGift() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(SLogicsCore.TheWorldTreeLogicData.CurGetGiftedId.length);
         _loc2_ = SLogicsCore.TheWorldTreeLogicData.TheWorldTreeCurLevel / 10;
         if(_loc2_ > _loc1_)
         {
            return true;
         }
         return false;
      }
      
      protected function UpdateInventory() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TGodtreeDrop = null;
         var _loc3_:int = 0;
         if(this.FLogicDate.TheWorldTreeCurLevel <= 10)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = Math.min(9,this.FLogicDate.TheWorldTreeCurLevel / 10);
         }
         _loc2_ = this.FCurBinsCopy.GetDatebaseByIndex(_loc1_) as TGodtreeDrop;
         this.FTempSelectInventoriesId.length = 0;
         this.FTempSelectInventoriesCount.length = 0;
         this.FSelectInventories.Clear();
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.DropListFixedAward.length)
            {
               if(_loc2_.DropListFixedAward[_loc3_].Code != 41)
               {
                  this.FTempSelectInventoriesId.push(_loc2_.DropListFixedAward[_loc3_].Code);
                  this.FTempSelectInventoriesCount.push(_loc2_.DropListFixedAward[_loc3_].Amount);
               }
               _loc3_++;
            }
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         _loc3_ = 0;
         while(_loc3_ < this.FSelectInventories.Count)
         {
            this.FSelectInventories.GetInventoryByIndex(_loc3_).Quantity = this.FTempSelectInventoriesCount[_loc3_];
            _loc3_++;
         }
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      public function set UpdateFiveSlot(param1:Function) : void
      {
         this.FUpdateFiveSlot = param1;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
   }
}


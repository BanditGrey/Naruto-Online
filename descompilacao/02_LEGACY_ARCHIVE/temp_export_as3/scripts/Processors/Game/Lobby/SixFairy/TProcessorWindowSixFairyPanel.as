package Processors.Game.Lobby.SixFairy
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Resources.Constants.CONST_SIXFAIRYMAIN;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_NINJIAREINCARNATION;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSixFairyPanel extends TProcessorLobbyWindow
   {
      
      public static const ten:int = 10;
      
      protected var FRootPanel:MovieClip = null;
      
      protected var FBreakThroughBtn:MovieClip = null;
      
      protected var FBreakThroughEXBtn:MovieClip = null;
      
      protected var FStrongBreakThroughBtn:MovieClip = null;
      
      protected var FGoldPracticeBtn:MovieClip = null;
      
      protected var FAdvancedPracticeBtn:MovieClip = null;
      
      protected var FGotoSixFairyPanelBtn:MovieClip = null;
      
      protected var FMC_MagicBigIcon:MovieClip = null;
      
      protected var FTF_MagicLevel:TextField = null;
      
      protected var FSixFairy_TF_StrongBreakThrough:TextField = null;
      
      protected var FSixFairy_TF_MC_StrongBreakThrough_Icon:TextField = null;
      
      protected var FBreakThroughFun:Function = null;
      
      protected var FGoldPracticehFun:Function = null;
      
      protected var FGotoSixFairyManFun:Function = null;
      
      protected var FSixFaryAllDataBase:SixFaryAllDataBase = null;
      
      protected var FMC_StrongBreakThrough_Icon:MovieClip;
      
      protected var FMC_BreakThrough_Icon:MovieClip;
      
      protected var FSixFairy_TF_UnlockExplanation:TextField;
      
      protected var FLevelupSixFairFun:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      public function TProcessorWindowSixFairyPanel(param1:TUIComponent, param2:SixFaryAllDataBase)
      {
         super(param1);
         this.FSixFaryAllDataBase = param2;
      }
      
      public function set LevelupSixFairFun(param1:Function) : void
      {
         this.FLevelupSixFairFun = param1;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function UpdateLogic() : void
      {
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         this.FRootPanel = param1;
         this.FBreakThroughBtn = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_BreakThrough];
         this.FBreakThroughEXBtn = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_BreakThroughEX];
         this.FStrongBreakThroughBtn = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_StrongBreakThrough];
         this.FGoldPracticeBtn = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_GoldPractice];
         this.FAdvancedPracticeBtn = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_AdvancedPractice];
         this.FGotoSixFairyPanelBtn = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_GotoSixFairyPanel];
         this.FMC_MagicBigIcon = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_MagicBigIcon];
         this.FSixFairy_TF_UnlockExplanation = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_TF_UnlockExplanation];
         this.FTF_MagicLevel = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_Experience][CONST_SIXFAIRYMAIN.SixFairy_TF_MagicLevel];
         this.FSixFairy_TF_StrongBreakThrough = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_TF_StrongBreakThrough];
         this.FSixFairy_TF_MC_StrongBreakThrough_Icon = this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_TF_MC_StrongBreakThrough_Icon];
         this.FMC_StrongBreakThrough_Icon = this.FRootPanel["MC_StrongBreakThrough_Icon"];
         this.FMC_BreakThrough_Icon = this.FRootPanel["MC_BreakThrough_Icon"];
         TGameUtil.setButtonMode(this.FGoldPracticeBtn,true);
         TGameUtil.setButtonMode(this.FAdvancedPracticeBtn,true);
         TGameUtil.setButtonMode(this.FGotoSixFairyPanelBtn,true);
         this.addEvent();
         new Tools_Help(FParent,this.FRootPanel[CONST_SIXFAIRYMAIN.BooldPurgatory_HelpBtn],CONST_SYSTEMLANGUAGE.HELPTIPS_SixFairyMan_Column,FUICore);
      }
      
      public function UpdateManual() : void
      {
         var _loc2_:String = null;
         this.FMC_MagicBigIcon.gotoAndStop(this.FSixFaryAllDataBase.CurPetPosition);
         this.UpdateStarState();
         this.UpdateAttri();
         TextField(this.FMC_MagicBigIcon[CONST_SIXFAIRYMAIN.SixFairy_MC_Name]["TF_Name"]).text = this.FSixFaryAllDataBase.CurPetName;
         var _loc1_:int = int(this.FSixFaryAllDataBase.CurReinCarnationLevel);
         if(_loc1_ > 0)
         {
            if(this.FSixFaryAllDataBase.CurPetPosition > 10)
            {
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.LevelLv_22,this.FSixFaryAllDataBase.CurPetPosition - 10,this.FSixFaryAllDataBase.CurPetLvel);
            }
            else
            {
               _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.LevelLv_00,this.FSixFaryAllDataBase.CurPetPosition,this.FSixFaryAllDataBase.CurPetLvel);
            }
         }
         else
         {
            _loc2_ = TUtilityString.Format(STRING_NINJIAREINCARNATION.LevelLv_11,this.FSixFaryAllDataBase.CurPetPosition,this.FSixFaryAllDataBase.CurPetLvel);
         }
         this.FTF_MagicLevel.text = _loc2_;
         if(this.FSixFaryAllDataBase.CurPetLvel == 10)
         {
            MovieClip(this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_Experience][CONST_SIXFAIRYMAIN.SixFairy_MC_ProgressBarExp]).scaleX = 1;
            TextField(this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_Experience][CONST_SIXFAIRYMAIN.SixFairy_TF_Experience]).text = "";
         }
         else
         {
            MovieClip(this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_Experience][CONST_SIXFAIRYMAIN.SixFairy_MC_ProgressBarExp]).scaleX = Number(this.FSixFaryAllDataBase.currExp) / Number(this.FSixFaryAllDataBase.CurToNextExp);
            TextField(this.FRootPanel[CONST_SIXFAIRYMAIN.SixFairy_MC_Experience][CONST_SIXFAIRYMAIN.SixFairy_TF_Experience]).text = this.FSixFaryAllDataBase.currExp + "/" + this.FSixFaryAllDataBase.CurToNextExp;
         }
         if(this.FSixFaryAllDataBase.SelectInventories.Count == 0)
         {
            return;
         }
         this.FSixFairy_TF_StrongBreakThrough.text = String(this.getInventoryById(this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(1)));
         this.FSixFairy_TF_MC_StrongBreakThrough_Icon.text = String(this.getInventoryById(this.FSixFaryAllDataBase.SelectInventories.GetInventoryByIndex(0)));
         if(this.FSixFaryAllDataBase.CurPetPosition == 20 && this.FSixFaryAllDataBase.CurPetLvel == 10 && this.FSixFaryAllDataBase.CurReinCarnationLevel == 3)
         {
            this.setThroughBtnState(false);
         }
         else if(this.FSixFaryAllDataBase.CurPetLvel >= 10)
         {
            this.setThroughBtnState(true);
         }
         else
         {
            this.setThroughBtnState(false);
         }
         if(SLogicsCore.Character.MainHero.Level < this.FSixFaryAllDataBase.UserLevel)
         {
            this.FSixFairy_TF_UnlockExplanation.visible = true;
            this.FSixFairy_TF_UnlockExplanation.text = TUtilityString.Format(STRING_TONGLING.TONGLING_49,SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(this.FSixFaryAllDataBase.UserLevel),this.FSixFaryAllDataBase.CurPetName);
         }
         else
         {
            this.FSixFairy_TF_UnlockExplanation.visible = false;
         }
      }
      
      public function setThroughBtnState(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FBreakThroughBtn,param1);
         TGameUtil.setButtonMode(this.FStrongBreakThroughBtn,param1);
         if(this.FBreakThroughEXBtn)
         {
            TGameUtil.setButtonMode(this.FBreakThroughEXBtn,param1);
            if(this.FSixFaryAllDataBase.CurPetPosition == 10 && (this.FSixFaryAllDataBase.CurReinCarnationLevel == 0 || this.FSixFaryAllDataBase.CurReinCarnationLevel == 1 || this.FSixFaryAllDataBase.CurReinCarnationLevel == 2))
            {
               this.FBreakThroughBtn.visible = false;
               this.FBreakThroughEXBtn.visible = true;
            }
            else
            {
               this.FBreakThroughBtn.visible = true;
               this.FBreakThroughEXBtn.visible = false;
            }
         }
         if(this.FSixFaryAllDataBase.CurPetPosition == 20 && this.FSixFaryAllDataBase.CurReinCarnationLevel == 3)
         {
            this.FBreakThroughBtn.visible = false;
            if(this.FBreakThroughEXBtn)
            {
               this.FBreakThroughEXBtn.visible = false;
            }
            this.FStrongBreakThroughBtn.visible = false;
         }
      }
      
      public function UpdateStarState() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= ten)
         {
            if(this.FSixFaryAllDataBase.CurPetLvel >= _loc1_)
            {
               MovieClip(this.FMC_MagicBigIcon["MC_Star_" + (_loc1_ - 1)]).gotoAndStop(1);
            }
            else
            {
               MovieClip(this.FMC_MagicBigIcon["MC_Star_" + (_loc1_ - 1)]).gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      public function UpdateAttri() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FSixFaryAllDataBase.CurPetAttri.length)
         {
            if(_loc1_ < 7)
            {
               if(_loc1_ <= 2)
               {
                  TextField(this.FRootPanel["TF_Attr0" + (_loc1_ + 1)]).text = String(this.FSixFaryAllDataBase.CurPetAttri[_loc1_]);
               }
               else
               {
                  TextField(this.FRootPanel["TF_Attr0" + (_loc1_ + 1)]).text = Number(this.FSixFaryAllDataBase.CurPetAttri[_loc1_] * 100).toFixed(1) + "%";
               }
            }
            _loc1_++;
         }
         if(this.FSixFaryAllDataBase.NextPetAttri.length == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < 7)
            {
               TextField(this.FRootPanel["TF_Attr1" + (_loc1_ + 1)]).text = "";
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.FSixFaryAllDataBase.NextPetAttri.length)
            {
               if(_loc1_ < 7)
               {
                  if(_loc1_ <= 2)
                  {
                     TextField(this.FRootPanel["TF_Attr1" + (_loc1_ + 1)]).text = String(this.FSixFaryAllDataBase.NextPetAttri[_loc1_]);
                  }
                  else
                  {
                     TextField(this.FRootPanel["TF_Attr1" + (_loc1_ + 1)]).text = Number(this.FSixFaryAllDataBase.NextPetAttri[_loc1_] * 100).toFixed(1) + "%";
                  }
               }
               _loc1_++;
            }
         }
      }
      
      protected function addEvent() : void
      {
         if(this.FBreakThroughEXBtn)
         {
            this.FBreakThroughEXBtn.addEventListener(MouseEvent.CLICK,this.BreakThroughBtnClick);
            this.FBreakThroughEXBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsHintOnOverFun);
            this.FBreakThroughEXBtn.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsHintOnOutFun);
         }
         this.FBreakThroughBtn.addEventListener(MouseEvent.CLICK,this.BreakThroughBtnClick);
         this.FStrongBreakThroughBtn.addEventListener(MouseEvent.CLICK,this.BreakThroughBtnClick);
         this.FGoldPracticeBtn.addEventListener(MouseEvent.CLICK,this.BreakThroughBtnClick);
         this.FAdvancedPracticeBtn.addEventListener(MouseEvent.CLICK,this.BreakThroughBtnClick);
         this.FGotoSixFairyPanelBtn.addEventListener(MouseEvent.CLICK,this.BreakThroughBtnClick);
         this.FBreakThroughBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsHintOnOverFun);
         this.FBreakThroughBtn.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsHintOnOutFun);
         this.FStrongBreakThroughBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsHintOnOverFun);
         this.FStrongBreakThroughBtn.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsHintOnOutFun);
         this.FAdvancedPracticeBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsHintOnOverFun);
         this.FAdvancedPracticeBtn.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsHintOnOutFun);
         this.FGoldPracticeBtn.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsHintOnOverFun);
         this.FGoldPracticeBtn.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsHintOnOutFun);
         this.FMC_StrongBreakThrough_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsHintOnOverFun);
         this.FMC_StrongBreakThrough_Icon.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsHintOnOutFun);
         this.FMC_BreakThrough_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsHintOnOverFun);
         this.FMC_BreakThrough_Icon.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsHintOnOutFun);
      }
      
      public function UIComponentsHintOnOverFun(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FMC_StrongBreakThrough_Icon:
               _loc2_ = 1;
               break;
            case this.FMC_BreakThrough_Icon:
               _loc2_ = 0;
               break;
            case this.FGoldPracticeBtn:
               _loc2_ = 2;
               break;
            case this.FAdvancedPracticeBtn:
               _loc2_ = 3;
               break;
            case this.FStrongBreakThroughBtn:
               _loc2_ = 4;
               break;
            case this.FBreakThroughBtn:
            case this.FBreakThroughEXBtn:
               _loc2_ = 5;
         }
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(_loc2_,null);
         }
      }
      
      public function UIComponentsHintOnOutFun(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FMC_StrongBreakThrough_Icon:
               _loc2_ = 1;
               break;
            case this.FMC_BreakThrough_Icon:
               _loc2_ = 0;
               break;
            case this.FGoldPracticeBtn:
               _loc2_ = 2;
               break;
            case this.FAdvancedPracticeBtn:
               _loc2_ = 3;
               break;
            case this.FStrongBreakThroughBtn:
               _loc2_ = 4;
               break;
            case this.FBreakThroughBtn:
            case this.FBreakThroughEXBtn:
               _loc2_ = 5;
         }
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(_loc2_,null);
         }
      }
      
      protected function limitOne() : Boolean
      {
         if(this.limitThree() == 2)
         {
            return true;
         }
         return false;
      }
      
      protected function limitTwo() : Boolean
      {
         if(this.FSixFaryAllDataBase.CurPetLvel < 10)
         {
            return true;
         }
         return false;
      }
      
      protected function limitThree() : int
      {
         var _loc1_:int = 9;
         switch(SLogicsCore.Character.GetMainHero().ReincarnationOneOrTwo)
         {
            case 0:
               if(this.FSixFaryAllDataBase.CurPetPosition == 10 && this.FSixFaryAllDataBase.CurPetLvel == 10 && this.FSixFaryAllDataBase.NextReinCarnationLevel == 1)
               {
                  _loc1_ = 0;
               }
               break;
            case 1:
               if(this.FSixFaryAllDataBase.CurPetPosition == 5 && this.FSixFaryAllDataBase.CurPetLvel == 10 && this.FSixFaryAllDataBase.NextReinCarnationLevel == 2)
               {
                  _loc1_ = 1;
               }
               break;
            case 2:
               if(this.FSixFaryAllDataBase.CurPetPosition == 20 && this.FSixFaryAllDataBase.CurPetLvel == 10 && this.FSixFaryAllDataBase.NextReinCarnationLevel == 7)
               {
                  _loc1_ = 2;
               }
         }
         return _loc1_;
      }
      
      public function BreakThroughBtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBreakThroughBtn:
            case this.FBreakThroughEXBtn:
               if(this.FBreakThroughFun != null)
               {
                  if(this.limitOne())
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_39);
                     return;
                  }
                  if(this.limitTwo())
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_40);
                     return;
                  }
                  if(this.limitThree() == 0)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_57);
                     return;
                  }
                  if(this.limitThree() == 1)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_58);
                     return;
                  }
                  this.FBreakThroughFun(7);
               }
               break;
            case this.FStrongBreakThroughBtn:
               if(this.FBreakThroughFun != null)
               {
                  if(this.limitOne())
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_39);
                     return;
                  }
                  if(this.limitTwo())
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_40);
                     return;
                  }
                  if(this.limitThree() == 0)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_57);
                     return;
                  }
                  if(this.limitThree() == 1)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_58);
                     return;
                  }
                  this.FBreakThroughFun(8);
               }
               break;
            case this.FGoldPracticeBtn:
               if(SLogicsCore.Character.MaxTempValue)
               {
                  return;
               }
               if(this.FGoldPracticehFun != null)
               {
                  if(this.limitOne())
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_39);
                     return;
                  }
                  if(!this.limitTwo())
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_41);
                     return;
                  }
                  if(this.limitThree() == 0)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_57);
                     return;
                  }
                  if(this.limitThree() == 1)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_58);
                     return;
                  }
                  this.FGoldPracticehFun(1);
               }
               break;
            case this.FAdvancedPracticeBtn:
               if(SLogicsCore.Character.MaxTempValue)
               {
                  return;
               }
               if(this.FGoldPracticehFun != null)
               {
                  if(this.limitOne())
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_39);
                     return;
                  }
                  if(!this.limitTwo())
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_41);
                     return;
                  }
                  if(this.limitThree() == 0)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_57);
                     return;
                  }
                  if(this.limitThree() == 1)
                  {
                     EffectGenerateText(STRING_TONGLING.TONGLING_58);
                     return;
                  }
                  this.FGoldPracticehFun(2);
               }
               break;
            case this.FGotoSixFairyPanelBtn:
               if(this.FGotoSixFairyManFun != null)
               {
                  this.FGotoSixFairyManFun();
               }
         }
      }
      
      protected function getInventoryById(param1:TInventory) : int
      {
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         return _loc2_.GetAllCountByTempletID(param1.IDTemplate);
      }
      
      public function set BreakThroughFun(param1:Function) : void
      {
         this.FBreakThroughFun = param1;
      }
      
      public function set GoldPracticehFun(param1:Function) : void
      {
         this.FGoldPracticehFun = param1;
      }
      
      public function set GotoSixFairyManFun(param1:Function) : void
      {
         this.FGotoSixFairyManFun = param1;
      }
   }
}


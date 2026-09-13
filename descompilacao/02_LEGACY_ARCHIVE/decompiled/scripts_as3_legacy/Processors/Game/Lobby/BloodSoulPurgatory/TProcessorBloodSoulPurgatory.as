package Processors.Game.Lobby.BloodSoulPurgatory
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorBloodSoulPurgatory extends TProcessorLobbyWindow
   {
      
      protected static var NUM_TAB:int = 5;
      
      protected var FMcPanel:Sprite;
      
      protected var FBloodSoulBtn:MovieClip;
      
      protected var FShortcutGetStuffBtn:MovieClip;
      
      protected var FBloodSoulChangeBtn:MovieClip;
      
      protected var FMC_Customs_Tab:Vector.<MovieClip>;
      
      protected var FMC_Customs_Tab_Visible:Vector.<Boolean>;
      
      protected var FMC_Customs_Tab_Pass:Vector.<MovieClip>;
      
      protected var FMC_Customs_Tab_Visible_index:Vector.<int>;
      
      protected var FBloodSoulBtnFun:Function;
      
      protected var FShortcutGetStuffBtnFun:Function;
      
      protected var FBloodSoulChangeBtnFun:Function;
      
      protected var FCustomsTabFun:Function;
      
      protected var FIsCanClick:Boolean = false;
      
      protected var FStateJudge:Boolean;
      
      public function TProcessorBloodSoulPurgatory(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Customs_Tab = new Vector.<MovieClip>(NUM_TAB);
         this.FMC_Customs_Tab_Visible = new Vector.<Boolean>(NUM_TAB);
         this.FMC_Customs_Tab_Pass = new Vector.<MovieClip>(NUM_TAB);
         this.FMC_Customs_Tab_Visible_index = new Vector.<int>(NUM_TAB);
      }
      
      public function setRootPanel(param1:Sprite) : void
      {
         this.FMcPanel = param1;
         var _loc2_:int = 0;
         this.FBloodSoulBtn = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_BloodSoulBtn];
         this.FShortcutGetStuffBtn = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_ShortcutGetStuffBtn];
         this.FBloodSoulChangeBtn = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_BloodSoulChangeBtn];
         TGameUtil.setButtonMode(this.FBloodSoulBtn,true);
         TGameUtil.setButtonMode(this.FShortcutGetStuffBtn,true);
         TGameUtil.setButtonMode(this.FBloodSoulChangeBtn,true);
         this.FBloodSoulBtn.addEventListener(MouseEvent.CLICK,this.BloodSoulBtnClick);
         this.FShortcutGetStuffBtn.addEventListener(MouseEvent.CLICK,this.ShortcutGetStuffBtnClick);
         this.FBloodSoulChangeBtn.addEventListener(MouseEvent.CLICK,this.BloodSoulChangeBtnClick);
         new Tools_Help(FParent,this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_HelpBtn],CONST_SYSTEMLANGUAGE.HELPTIPS_BloodSoulPurgatory_Purgatory,FUICore);
         _loc2_ = 0;
         while(_loc2_ < NUM_TAB)
         {
            this.FMC_Customs_Tab[_loc2_] = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_Customs_Tab_ + _loc2_];
            this.FMC_Customs_Tab_Pass[_loc2_] = this.FMcPanel[CONST_BLOODPURGATORY.BooldPurgatory_Customs_Tab_ + _loc2_]["MC_Pass"];
            this.FMC_Customs_Tab[_loc2_].buttonMode = true;
            this.FMC_Customs_Tab[_loc2_].addEventListener(MouseEvent.CLICK,this.CustomsTabClick);
            _loc2_++;
         }
         if(!SLogicsCore.Character.GetConfigValueById(91000011))
         {
            this.FMC_Customs_Tab[3].visible = false;
         }
      }
      
      public function GetCustomLayer(param1:int, param2:int, param3:int, param4:TProcessorBloodPurgatory) : void
      {
         var _loc5_:int = 0;
         if(!this.FBloodSoulBtn)
         {
            return;
         }
         var _loc6_:int = param1;
         _loc5_ = 0;
         while(_loc5_ < NUM_TAB)
         {
            if(param1 < _loc5_)
            {
               this.FMC_Customs_Tab_Pass[_loc5_].visible = false;
               this.FMC_Customs_Tab[_loc5_].gotoAndStop(3);
               this.FMC_Customs_Tab_Visible[_loc5_] = false;
               TextField(this.FMC_Customs_Tab[_loc5_].MC_Schedule).text = STRING_TONGLING.TONGLING_29 + (_loc5_ == 3 ? "0/30" : "0/15");
               this.FMC_Customs_Tab_Visible_index[_loc5_] = 7;
            }
            else
            {
               this.FMC_Customs_Tab[_loc5_].filters = [];
               this.FMC_Customs_Tab[_loc5_].gotoAndStop(1);
               if(_loc6_ > _loc5_)
               {
                  this.FMC_Customs_Tab_Visible[_loc5_] = false;
                  this.FMC_Customs_Tab_Pass[_loc5_].visible = true;
                  this.FMC_Customs_Tab[_loc5_].gotoAndStop(1);
                  this.FMC_Customs_Tab_Visible_index[_loc5_] = 2;
                  TextField(this.FMC_Customs_Tab[_loc5_].MC_Schedule).text = STRING_TONGLING.TONGLING_29 + (_loc5_ == 3 ? "30/30" : "15/15");
               }
               else if(_loc5_ != 3 && param2 == 2 && param3 == 5 || _loc5_ == 3 && param2 == 5 && param3 == 5)
               {
                  if(_loc6_ == _loc5_)
                  {
                     this.FMC_Customs_Tab_Visible[_loc5_] = false;
                     this.FMC_Customs_Tab_Visible_index[_loc5_] = 2;
                     this.FMC_Customs_Tab_Pass[_loc5_].visible = true;
                     this.FMC_Customs_Tab[_loc5_].gotoAndStop(1);
                     TextField(this.FMC_Customs_Tab[_loc5_].MC_Schedule).text = STRING_TONGLING.TONGLING_29 + (_loc5_ == 3 ? "30/30" : "15/15");
                     param1++;
                     param2 = 0;
                     param3 = 0;
                  }
                  else
                  {
                     this.FMC_Customs_Tab_Visible[_loc5_] = true;
                     this.FMC_Customs_Tab_Pass[_loc5_].visible = false;
                     this.FMC_Customs_Tab[_loc5_].gotoAndStop(1);
                     TextField(this.FMC_Customs_Tab[_loc5_].MC_Schedule).text = STRING_TONGLING.TONGLING_29 + (param2 * 5 + param3) + (_loc5_ == 3 ? "/30" : "/15");
                  }
               }
               else
               {
                  this.FMC_Customs_Tab_Visible[_loc5_] = true;
                  this.FMC_Customs_Tab_Pass[_loc5_].visible = false;
                  this.FMC_Customs_Tab[_loc5_].gotoAndStop(1);
                  TextField(this.FMC_Customs_Tab[_loc5_].MC_Schedule).text = STRING_TONGLING.TONGLING_29 + (param2 * 5 + param3) + (_loc5_ == 3 ? "/30" : "/15");
               }
            }
            _loc5_++;
         }
         param4.GetCustomLayer(param1,param2,param3);
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(!this.FMcPanel)
         {
            return;
         }
         this.FMcPanel.visible = param1;
      }
      
      public function ZeroReset() : void
      {
         this.SetGetStuffBtn(true);
      }
      
      public function BloodSoulBtnClick(param1:MouseEvent) : void
      {
         if(this.FBloodSoulBtnFun != null)
         {
            this.FBloodSoulBtnFun();
         }
      }
      
      public function ShortcutGetStuffBtnClick(param1:MouseEvent) : void
      {
         if(this.FShortcutGetStuffBtnFun != null && this.FIsCanClick)
         {
            this.FShortcutGetStuffBtnFun();
         }
         else
         {
            EffectGenerateText(STRING_TONGLING.TONGLING_31);
         }
      }
      
      public function BloodSoulChangeBtnClick(param1:MouseEvent) : void
      {
         if(this.FBloodSoulChangeBtnFun != null)
         {
            this.FBloodSoulChangeBtnFun();
         }
      }
      
      public function CustomsTabClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this.FCustomsTabFun != null)
         {
            _loc2_ = param1.currentTarget.name;
            _loc3_ = int(_loc2_.charAt(_loc2_.length - 1));
            if(this.FMC_Customs_Tab_Visible[_loc3_])
            {
               this.FCustomsTabFun(_loc3_);
            }
            else if(this.FMC_Customs_Tab_Visible_index[_loc3_] == 2)
            {
               EffectGenerateText(STRING_TONGLING.TONGLING_36);
            }
            else if(this.FMC_Customs_Tab_Visible_index[_loc3_] == 7)
            {
               EffectGenerateText(STRING_TONGLING.TONGLING_33);
            }
         }
      }
      
      public function CustomBack(param1:int) : void
      {
      }
      
      public function set BloodSoulBtnFun(param1:Function) : void
      {
         this.FBloodSoulBtnFun = param1;
      }
      
      public function set ShortcutGetStuffBtnFun(param1:Function) : void
      {
         this.FShortcutGetStuffBtnFun = param1;
      }
      
      public function set BloodSoulChangeBtnFun(param1:Function) : void
      {
         this.FBloodSoulChangeBtnFun = param1;
      }
      
      public function set CustomsTabFun(param1:Function) : void
      {
         this.FCustomsTabFun = param1;
      }
      
      public function SetGetStuffBtn(param1:Boolean) : void
      {
         this.FStateJudge = param1;
      }
      
      public function UpDateStuffBtn() : void
      {
         TGameUtil.setButtonMode(this.FShortcutGetStuffBtn,this.FStateJudge);
         if(this.FStateJudge)
         {
            this.FIsCanClick = true;
         }
         else
         {
            this.FIsCanClick = false;
         }
      }
   }
}


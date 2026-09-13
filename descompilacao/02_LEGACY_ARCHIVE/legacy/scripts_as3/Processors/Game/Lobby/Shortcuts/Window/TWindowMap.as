package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.*;
   import Externals.SExternalCore;
   import Foundation.Common.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Sound.SMusicPlayer;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import LocalStorages.SLocalStoragelCore;
   import Logics.Agent.SParametersCore;
   import Logics.AntiAddiction.TAntiAddiction;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Display.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   import ghostcat.operation.*;
   import ghostcat.util.easing.Cubic;
   
   public class TWindowMap extends TUIComponent
   {
      
      public static const MAP_TYPE:Vector.<uint> = CONST_SHORTCUTS.MAP_TYPE;
      
      public static const RESOURCE_ClassName_Map_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_Map_Btns;
      
      public static const CAPTIONS_HintMapButtonCaption:Vector.<String> = STRING_SHORTCUTS.CAPTIONS_HintMapButtonCaption;
      
      public static const CAPTIONS_HintMapMovieClipCaption:Vector.<String> = STRING_SHORTCUTS.CAPTIONS_HintMapMovieClipCaption;
      
      public static const TYPE_Map:uint = CONST_SHORTCUTS.TYPE_Map;
      
      public static const TYPE_ReturnHome:uint = CONST_SHORTCUTS.TYPE_ReturnHome;
      
      public static const TYPE_AutoBattle:uint = CONST_SHORTCUTS.TYPE_AutoBattle;
      
      public static const CAPACITY_SimpleButton:uint = 5;
      
      public static const CAPACITY_MovieClip:uint = 2;
      
      public static const TYPE_Map_Mail:uint = CONST_SHORTCUTS.TYPE_Map_Mail;
      
      public static const TYPE_Function_Mail:uint = CONST_SHORTCUTS.TYPE_Function_Mail;
      
      public static const TYPE_AutoBattle_Ok:String = "ok";
      
      public static const TYPE_AutoBattle_Cancel:String = "cancel";
      
      protected var FAntiAddiction:TAntiAddiction;
      
      protected var FRepeatOper:RepeatOper;
      
      protected var FTweenOperIn:TweenOper;
      
      protected var FTweenOperOut:TweenOper;
      
      protected var FMCEnterMap:Sprite;
      
      protected var FMCReturnHome:Sprite;
      
      protected var FBtn_EnterMap:SimpleButton;
      
      protected var FBtn_ReturnHome:SimpleButton;
      
      protected var FBtn_ViewRaiders:SimpleButton;
      
      protected var FTF_Caption:TextField;
      
      protected var FTF_Quantity:TextField;
      
      protected var FButtonsEnter:Vector.<SimpleButton>;
      
      protected var FMovieClipsEnter:Vector.<MovieClip>;
      
      protected var FButtonsReturn:Vector.<SimpleButton>;
      
      protected var FMovieClipsReturn:Vector.<MovieClip>;
      
      protected var FBtn_EMail:SimpleButton;
      
      protected var FBtn_EQuest:SimpleButton;
      
      protected var FBtn_EFriend:SimpleButton;
      
      protected var FBtn_ESystem:SimpleButton;
      
      protected var FMC_ESwitchDisplay:MovieClip;
      
      protected var FMC_ESwitchSound:MovieClip;
      
      protected var FBtn_ECDK:SimpleButton;
      
      protected var FBtn_RMail:SimpleButton;
      
      protected var FBtn_RQuest:SimpleButton;
      
      protected var FBtn_RFriend:SimpleButton;
      
      protected var FBtn_RSystem:SimpleButton;
      
      protected var FMC_RSwitchDisplay:MovieClip;
      
      protected var FMC_RSwitchSound:MovieClip;
      
      protected var FBtn_RCDK:SimpleButton;
      
      protected var FHintBtn:THint;
      
      protected var FHintAutoBattle:THint;
      
      protected var FHintAutoGoldResurgence:THint;
      
      protected var FHintAutoSkipResurgence:THint;
      
      protected var FWidth:int;
      
      protected var FShortcutCapacity:int;
      
      protected var FIsExpand:Boolean;
      
      protected var FIsDisplayRole:Boolean;
      
      protected var FIsInitialization:Boolean;
      
      protected var FEffectBaseGlowEnterMap:TEffectBaseGlow;
      
      protected var FEffectBaseGlowReturnHome:TEffectBaseGlow;
      
      protected var FEffectBaseGlowReturnFriend:TEffectBaseGlow;
      
      protected var FTF_Timer_EnterMap:TextField;
      
      protected var FTF_Timer_ReturnHome:TextField;
      
      protected var FMC_Active_AutoBattle:MovieClip;
      
      protected var FBtn_Active_AutoBattle:MovieClip;
      
      protected var FMC_Active_AutoGoldResurgence:MovieClip;
      
      protected var FBtn_Active_AutoGoldResurgence:MovieClip;
      
      protected var FMC_Active_AutoSkipResurgence:MovieClip;
      
      protected var FBtn_Active_AutoSkipResurgence:MovieClip;
      
      protected var FIsAutoBattle:Boolean;
      
      protected var FIsAutoGoldResurgence:Boolean;
      
      protected var FIsAutoSkipResurgence:Boolean;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FOffestWidth:int;
      
      protected var FReqEnd:Boolean;
      
      protected var FOnWorldMap:Function;
      
      protected var FOnReturnHome:Function;
      
      protected var FOnViewRaiders:Function;
      
      protected var FOnMail:Function;
      
      protected var FOnQuest:Function;
      
      protected var FOnFriend:Function;
      
      protected var FOnSwitchDisplay:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FHelpHintOnMove:Function;
      
      protected var FHelpHintOnOut:Function;
      
      protected var FAutoBattle:Function;
      
      protected var FZeroReq:Function;
      
      protected var FBtn_BT:SimpleButton;
      
      protected var GoldOrSkip:int;
      
      protected var SkipResurgenceBtnIsCanUse:Boolean;
      
      public function TWindowMap(param1:TUIComponent)
      {
         super(param1);
         this.FAntiAddiction = SLogicsCore.AntiAddiction;
         this.FHintBtn = new THint();
         this.FHintAutoBattle = new THint();
         this.FHintAutoGoldResurgence = new THint();
         this.FHintAutoSkipResurgence = new THint();
         this.FButtonsEnter = new Vector.<SimpleButton>(CAPACITY_SimpleButton);
         this.FMovieClipsEnter = new Vector.<MovieClip>(CAPACITY_MovieClip);
         this.FButtonsReturn = new Vector.<SimpleButton>(CAPACITY_SimpleButton);
         this.FMovieClipsReturn = new Vector.<MovieClip>(CAPACITY_MovieClip);
         this.FWidth = 0;
         this.FShortcutCapacity = MAP_TYPE.length;
         this.ConstructTween();
         this.FIsDisplayRole = true;
         this.FIsInitialization = false;
         this.FReqEnd = true;
      }
      
      protected function ConstructTween() : void
      {
         this.FRepeatOper = new RepeatOper();
         this.FTweenOperIn = new TweenOper();
         this.FTweenOperOut = new TweenOper();
         this.FTweenOperIn.duration = 10;
         this.FTweenOperIn.params = {
            "alpha":0,
            "y":74,
            "ease":Cubic.easeIn
         };
         this.FTweenOperOut.duration = 300;
         this.FTweenOperOut.params = {
            "alpha":1,
            "y":113,
            "ease":Cubic.easeOut
         };
         this.FRepeatOper.loop = 1;
         this.FRepeatOper.children = [this.FTweenOperIn,this.FTweenOperOut];
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:String = null;
         var _loc2_:TSystemLanguage = null;
         this.FMCEnterMap = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHORTCUTS.RESOURCE_ClassName_EnterMap) as Sprite;
         this.FMCEnterMap.visible = false;
         this.addChild(this.FMCEnterMap);
         this.FBtn_BT = this.FMCEnterMap[CONST_SHORTCUTS.RESOURCE_Link_Btn_BT];
         if(this.FBtn_BT)
         {
            if(SParametersCore.AgentID == 105 || SParametersCore.AgentID == 108)
            {
               this.FBtn_BT.visible = true;
            }
            else
            {
               this.FBtn_BT.visible = false;
            }
         }
         this.FTF_Timer_EnterMap = this.FMCEnterMap[CONST_SHORTCUTS.RESOURCE_Link_MC_Time][CONST_SHORTCUTS.RESOURCE_Link_TF_Time];
         this.FBtn_EnterMap = this.FMCEnterMap[CONST_SHORTCUTS.RESOURCE_Link_Btn_EnterMap];
         this.FBtn_EMail = this.FMCEnterMap[CONST_SHORTCUTS.RESOURCE_Link_Btn_Mail];
         this.FBtn_EQuest = this.FMCEnterMap[CONST_SHORTCUTS.RESOURCE_Link_Btn_Quest];
         this.FBtn_EFriend = this.FMCEnterMap[CONST_SHORTCUTS.RESOURCE_Link_Btn_Friend];
         this.FButtonsEnter[0] = this.FBtn_EnterMap;
         this.FButtonsEnter[1] = this.FBtn_EMail;
         this.FButtonsEnter[2] = this.FBtn_EQuest;
         this.FButtonsEnter[3] = this.FBtn_EFriend;
         this.FButtonsEnter[4] = this.FBtn_ESystem;
         this.FButtonsEnter[5] = this.FBtn_ECDK;
         this.FMC_ESwitchDisplay = this.FMCEnterMap[CONST_SHORTCUTS.RESOURCE_Link_Btn_SwitchDisplay];
         this.FMC_ESwitchSound = this.FMCEnterMap[CONST_SHORTCUTS.RESOURCE_Link_Btn_SwitchSound];
         this.FMovieClipsEnter[0] = this.FMC_ESwitchDisplay;
         this.FMovieClipsEnter[1] = this.FMC_ESwitchSound;
         this.FMCReturnHome = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHORTCUTS.RESOURCE_ClassName_ReturnHome) as Sprite;
         addChild(this.FMCReturnHome);
         this.FMCReturnHome.visible = false;
         this.FTF_Timer_ReturnHome = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_MC_Time][CONST_SHORTCUTS.RESOURCE_Link_TF_Time];
         this.FMC_Active_AutoBattle = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_MC_AutoBattle];
         this.FBtn_Active_AutoBattle = this.FMC_Active_AutoBattle[CONST_SHORTCUTS.RESOURCE_Link_Btn_AutoBattle];
         this.FBtn_Active_AutoBattle.gotoAndStop(TYPE_AutoBattle_Cancel);
         this.FIsAutoBattle = false;
         this.FMC_Active_AutoGoldResurgence = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_MC_AutoGoldResurgence];
         this.FBtn_Active_AutoGoldResurgence = this.FMC_Active_AutoGoldResurgence[CONST_SHORTCUTS.RESOURCE_Link_Btn_AutoBattle];
         this.FBtn_Active_AutoGoldResurgence.gotoAndStop(TYPE_AutoBattle_Cancel);
         this.FIsAutoGoldResurgence = false;
         this.FMC_Active_AutoSkipResurgence = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_MC_AutoSkipResurgence];
         this.FBtn_Active_AutoSkipResurgence = this.FMC_Active_AutoSkipResurgence[CONST_SHORTCUTS.RESOURCE_Link_Btn_AutoBattle];
         this.FBtn_Active_AutoSkipResurgence.gotoAndStop(TYPE_AutoBattle_Cancel);
         this.FIsAutoSkipResurgence = false;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ACTIVITY_AUTOBATTLE_INTRO) as TSystemLanguage;
         this.FHintAutoBattle.Content = _loc2_.Desc;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ACTIVITY_AUTOGOLD_INTRO) as TSystemLanguage;
         this.FHintAutoGoldResurgence.Content = _loc2_.Desc;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.ACTIVITY_AUTOSKIP_INTRO) as TSystemLanguage;
         this.FHintAutoSkipResurgence.Content = _loc2_.Desc;
         this.FBtn_ReturnHome = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_Btn_ReturnHome];
         this.FBtn_ViewRaiders = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_Btn_ViewRaiders];
         this.FTF_Caption = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_TF_Caption];
         this.FTF_Quantity = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_TF_Quantity];
         this.FBtn_ViewRaiders.visible = false;
         this.FBtn_RMail = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_Btn_Mail];
         this.FBtn_RQuest = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_Btn_Quest];
         this.FBtn_RFriend = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_Btn_Friend];
         this.FButtonsReturn[0] = this.FBtn_EnterMap;
         this.FButtonsReturn[1] = this.FBtn_RMail;
         this.FButtonsReturn[2] = this.FBtn_RQuest;
         this.FButtonsReturn[3] = this.FBtn_RFriend;
         this.FButtonsReturn[4] = this.FBtn_RSystem;
         this.FButtonsReturn[5] = this.FBtn_RCDK;
         if(this.FBtn_BT)
         {
            this.FButtonsReturn[6] = this.FBtn_BT;
         }
         this.FMC_RSwitchDisplay = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_Btn_SwitchDisplay];
         this.FMC_RSwitchSound = this.FMCReturnHome[CONST_SHORTCUTS.RESOURCE_Link_Btn_SwitchSound];
         this.FMovieClipsReturn[0] = this.FMC_RSwitchDisplay;
         this.FMovieClipsReturn[1] = this.FMC_RSwitchSound;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(false);
      }
      
      protected function Resources_UILocations() : void
      {
         this.FBtn_EnterMap.addEventListener(MouseEvent.CLICK,this.BtnEnterMapOnClick,false,0,true);
         this.FBtn_ReturnHome.addEventListener(MouseEvent.CLICK,this.BtnReturnHomeOnClick,false,0,true);
         this.FBtn_ViewRaiders.addEventListener(MouseEvent.CLICK,this.BtnViewRaidersOnClick,false,0,true);
         this.FBtn_EMail.addEventListener(MouseEvent.CLICK,this.BtnMailOnClick,false,0,true);
         this.FBtn_EMail.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FBtn_EMail.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         this.FBtn_EQuest.addEventListener(MouseEvent.CLICK,this.BtnQuestOnClick,false,0,true);
         this.FBtn_EQuest.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FBtn_EQuest.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         this.FBtn_EFriend.addEventListener(MouseEvent.CLICK,this.BtnFriendOnClick,false,0,true);
         this.FBtn_EFriend.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FBtn_EFriend.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         if(this.FBtn_ESystem != null)
         {
            this.FBtn_ESystem.addEventListener(MouseEvent.CLICK,this.BtnSystemOnClick,false,0,true);
            this.FBtn_ESystem.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
            this.FBtn_ESystem.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         }
         this.FMC_ESwitchSound.addEventListener(MouseEvent.CLICK,this.BtnSwitchSoundOnClick,false,0,true);
         this.FMC_ESwitchSound.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FMC_ESwitchSound.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         this.FMC_ESwitchDisplay.addEventListener(MouseEvent.CLICK,this.BtnSwitchDisplayOnClick,false,0,true);
         this.FMC_ESwitchDisplay.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FMC_ESwitchDisplay.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         if(this.FBtn_ECDK != null)
         {
            this.FBtn_ECDK.addEventListener(MouseEvent.CLICK,this.BtnCDKOnClick,false,0,true);
            this.FBtn_ECDK.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
            this.FBtn_ECDK.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         }
         this.FBtn_RMail.addEventListener(MouseEvent.CLICK,this.BtnMailOnClick,false,0,true);
         this.FBtn_RMail.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FBtn_RMail.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         this.FBtn_RQuest.addEventListener(MouseEvent.CLICK,this.BtnQuestOnClick,false,0,true);
         this.FBtn_RQuest.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FBtn_RQuest.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         this.FBtn_RFriend.addEventListener(MouseEvent.CLICK,this.BtnFriendOnClick,false,0,true);
         this.FBtn_RFriend.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FBtn_RFriend.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         if(this.FBtn_RSystem != null)
         {
            this.FBtn_RSystem.addEventListener(MouseEvent.CLICK,this.BtnSystemOnClick,false,0,true);
            this.FBtn_RSystem.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
            this.FBtn_RSystem.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         }
         this.FMC_RSwitchDisplay.addEventListener(MouseEvent.CLICK,this.BtnSwitchDisplayOnClick,false,0,true);
         this.FMC_RSwitchDisplay.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FMC_RSwitchDisplay.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         this.FMC_RSwitchSound.addEventListener(MouseEvent.CLICK,this.BtnSwitchSoundOnClick,false,0,true);
         this.FMC_RSwitchSound.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
         this.FMC_RSwitchSound.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         if(this.FBtn_RCDK != null)
         {
            this.FBtn_RCDK.addEventListener(MouseEvent.CLICK,this.BtnCDKOnClick,false,0,true);
            this.FBtn_RCDK.addEventListener(MouseEvent.MOUSE_MOVE,this.BtnOnOver,false,0,true);
            this.FBtn_RCDK.addEventListener(MouseEvent.MOUSE_OUT,this.BtnOnOut,false,0,true);
         }
         this.FMC_Active_AutoBattle.addEventListener(MouseEvent.MOUSE_MOVE,this.AutoBattleOnOver,false,0,true);
         this.FMC_Active_AutoBattle.addEventListener(MouseEvent.MOUSE_OUT,this.AutoBattleOnOut,false,0,true);
         this.FMC_Active_AutoGoldResurgence.addEventListener(MouseEvent.MOUSE_MOVE,this.AutoBattleOnOver,false,0,true);
         this.FMC_Active_AutoGoldResurgence.addEventListener(MouseEvent.MOUSE_OUT,this.AutoBattleOnOut,false,0,true);
         this.FMC_Active_AutoSkipResurgence.addEventListener(MouseEvent.MOUSE_MOVE,this.AutoBattleOnOver,false,0,true);
         this.FMC_Active_AutoSkipResurgence.addEventListener(MouseEvent.MOUSE_OUT,this.AutoBattleOnOut,false,0,true);
         this.FBtn_Active_AutoBattle.addEventListener(MouseEvent.CLICK,this.OnAutoBattleClick);
         this.FBtn_Active_AutoGoldResurgence.addEventListener(MouseEvent.CLICK,this.OnAutoBattleClick);
         this.FBtn_Active_AutoSkipResurgence.addEventListener(MouseEvent.CLICK,this.OnAutoBattleClick);
         if(this.FBtn_BT)
         {
            this.FBtn_BT.addEventListener(MouseEvent.CLICK,this.BtnBTOnClick);
         }
         this.FIsInitialization = true;
      }
      
      protected function BtnBTOnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(SParametersCore.AgentID == 105)
         {
            _loc2_ = "https://discord.gg/EcmGqm";
         }
         if(SParametersCore.AgentID == 108)
         {
            _loc2_ = "https://discord.gg/GTQRJM";
         }
         SExternalCore.NavigateToUrl(_loc2_);
      }
      
      protected function UpdateBounds() : void
      {
         if(this.FIsInitialization == false)
         {
            return;
         }
         if(this.FMCEnterMap.visible)
         {
            this.FOffestWidth = 63;
            this.FWidth = this.FMCEnterMap.width;
         }
         else if(this.FMCReturnHome.visible)
         {
            this.FOffestWidth = 0;
            this.FWidth = this.FMCReturnHome.width;
         }
         else
         {
            this.FWidth = 0;
         }
      }
      
      protected function ProcessorUpdateReturnHomePanel(param1:String, param2:String) : void
      {
         this.FTF_Caption.text = param1;
         this.FTF_Quantity.text = param2;
      }
      
      protected function UpdateEffectsGlow() : void
      {
         if(this.FEffectBaseGlowEnterMap != null && this.FEffectBaseGlowEnterMap.IsRunOver)
         {
            this.FEffectBaseGlowEnterMap.Run();
         }
         if(this.FEffectBaseGlowReturnHome != null && this.FEffectBaseGlowReturnHome.IsRunOver)
         {
            this.FEffectBaseGlowReturnHome.Run();
         }
         if(this.FEffectBaseGlowReturnFriend != null && this.FEffectBaseGlowReturnFriend.IsRunOver)
         {
            this.FEffectBaseGlowReturnFriend.Run();
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         if(param2)
         {
            this.OpenButtonEffect(param1);
         }
         else
         {
            this.TerminationButtonEffect(param1);
         }
      }
      
      protected function ProcessorShortcutShowEffectCopy(param1:uint, param2:Boolean) : void
      {
         if(param2)
         {
            if(this.FEffectBaseGlowReturnFriend == null)
            {
               this.FEffectBaseGlowReturnFriend = new TEffectBaseGlow();
               if(!this.FEffectBaseGlowReturnFriend.IsRunOver)
               {
                  this.FEffectBaseGlowReturnFriend.SetParameters(this.FBtn_EFriend,15911245,1);
                  this.FEffectBaseGlowReturnFriend.Run();
               }
            }
            else if(!this.FEffectBaseGlowReturnFriend.IsRunOver)
            {
               this.FEffectBaseGlowReturnFriend.Run();
            }
         }
         else if(this.FBtn_EFriend != null)
         {
            if(this.FEffectBaseGlowReturnFriend != null)
            {
               this.FEffectBaseGlowReturnFriend.Stop();
               this.FEffectBaseGlowReturnFriend.Dispose();
               this.FEffectBaseGlowReturnFriend = null;
            }
         }
      }
      
      protected function OpenButtonEffect(param1:int) : void
      {
         if(this.FEffectBaseGlowEnterMap == null)
         {
            this.FEffectBaseGlowEnterMap = new TEffectBaseGlow();
            if(!this.FEffectBaseGlowEnterMap.IsRunOver)
            {
               this.FEffectBaseGlowEnterMap.SetParameters(this.FBtn_EMail,15911245,1);
               this.FEffectBaseGlowEnterMap.Run();
            }
         }
         if(this.FEffectBaseGlowReturnHome == null)
         {
            this.FEffectBaseGlowReturnHome = new TEffectBaseGlow();
            if(!this.FEffectBaseGlowReturnHome.IsRunOver)
            {
               this.FEffectBaseGlowReturnHome.SetParameters(this.FBtn_RMail,15911245,1);
               this.FEffectBaseGlowReturnHome.Run();
            }
         }
      }
      
      protected function TerminationButtonEffect(param1:int) : void
      {
         var _loc2_:SimpleButton = null;
         _loc2_ = this.FButtonsEnter[param1];
         if(_loc2_ != null)
         {
            if(this.FEffectBaseGlowEnterMap != null)
            {
               if(_loc2_ == this.FEffectBaseGlowEnterMap.Source)
               {
                  this.FEffectBaseGlowEnterMap.Stop();
                  this.FEffectBaseGlowEnterMap.Dispose();
                  this.FEffectBaseGlowEnterMap = null;
               }
            }
         }
         _loc2_ = this.FButtonsReturn[param1];
         if(_loc2_ != null)
         {
            if(this.FEffectBaseGlowReturnHome != null)
            {
               if(_loc2_ == this.FEffectBaseGlowReturnHome.Source)
               {
                  this.FEffectBaseGlowReturnHome.Stop();
                  this.FEffectBaseGlowReturnHome.Dispose();
                  this.FEffectBaseGlowReturnHome = null;
               }
            }
         }
      }
      
      protected function UpdateTime() : void
      {
         var _loc1_:Date = null;
         var _loc2_:String = null;
         _loc1_ = new Date(STimingCore.GetClientShowTime(STimingCore.GetServerTick()) * 1000);
         _loc2_ = TUtilityDate.FormatTime(_loc1_);
         if(this.FTF_Timer_EnterMap != null)
         {
            this.FTF_Timer_EnterMap.text = _loc2_;
         }
         if(this.FTF_Timer_ReturnHome != null)
         {
            this.FTF_Timer_ReturnHome.text = _loc2_;
         }
         if(_loc1_.hours == 0 && _loc1_.minutes == 5 && _loc1_.seconds == 0 && this.FReqEnd)
         {
            if(this.FZeroReq != null)
            {
               this.FZeroReq(this);
            }
            this.FReqEnd = false;
         }
         if(_loc1_.hours == 0 && _loc1_.minutes == 5 && _loc1_.seconds > 10)
         {
            this.FReqEnd = true;
         }
      }
      
      protected function BtnEnterMapOnClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleButton = null;
         _loc2_ = param1.currentTarget as SimpleButton;
         if(this.FOnWorldMap != null)
         {
            this.FOnWorldMap(this);
         }
      }
      
      protected function BtnReturnHomeOnClick(param1:MouseEvent) : void
      {
         if(this.FOnReturnHome != null)
         {
            this.FOnReturnHome(this);
         }
      }
      
      protected function BtnViewRaidersOnClick(param1:MouseEvent) : void
      {
         if(this.FOnViewRaiders != null)
         {
            this.FOnViewRaiders(this);
         }
      }
      
      protected function BtnMailOnClick(param1:MouseEvent) : void
      {
         if(this.FOnMail != null)
         {
            this.FOnMail(this);
         }
      }
      
      protected function BtnQuestOnClick(param1:MouseEvent) : void
      {
         if(this.FOnQuest != null)
         {
            this.FOnQuest(this);
         }
      }
      
      protected function BtnFriendOnClick(param1:MouseEvent) : void
      {
         if(this.FOnFriend != null)
         {
            this.FOnFriend(this);
         }
      }
      
      protected function BtnSystemOnClick(param1:MouseEvent) : void
      {
      }
      
      protected function BtnSwitchSoundOnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         _loc2_ = 3 - this.FMC_ESwitchSound.currentFrame;
         this.FMC_ESwitchSound.gotoAndStop(_loc2_);
         this.FMC_RSwitchSound.gotoAndStop(_loc2_);
         _loc3_ = !SMusicPlayer.Mute;
         SMusicPlayer.Mute = _loc3_;
         SLogicsCore.AntiAddiction.SoundMute = _loc3_;
         SLocalStoragelCore.Flush(SLogicsCore.AntiAddiction.Data);
      }
      
      protected function BtnSwitchDisplayOnClick(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         _loc2_ = !this.FIsDisplayRole;
         if(_loc2_)
         {
            _loc3_ = 1;
         }
         else
         {
            _loc3_ = 2;
         }
         this.FMC_ESwitchDisplay.gotoAndStop(_loc3_);
         this.FMC_RSwitchDisplay.gotoAndStop(_loc3_);
         if(this.FOnSwitchDisplay != null)
         {
            this.FOnSwitchDisplay(this,_loc2_);
         }
         this.FIsDisplayRole = _loc2_;
      }
      
      protected function BtnCDKOnClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleButton = null;
         if(param1 != null && param1.target is SimpleButton)
         {
            _loc2_ = param1.target as SimpleButton;
         }
         switch(_loc2_)
         {
            case this.FBtn_ECDK:
            case this.FBtn_RCDK:
         }
      }
      
      protected function BtnOnOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Vector.<String> = null;
         var _loc6_:String = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.currentTarget is SimpleButton)
         {
            _loc3_ = param1.currentTarget as SimpleButton;
            _loc2_ = this.FButtonsEnter.indexOf(_loc3_);
            if(_loc2_ < 0)
            {
               _loc2_ = this.FButtonsReturn.indexOf(_loc3_);
            }
            _loc5_ = CAPTIONS_HintMapButtonCaption;
         }
         else if(param1.currentTarget is MovieClip)
         {
            _loc4_ = param1.currentTarget as MovieClip;
            _loc2_ = this.FMovieClipsEnter.indexOf(_loc4_);
            if(_loc2_ < 0)
            {
               _loc2_ = this.FMovieClipsReturn.indexOf(_loc4_);
            }
            _loc5_ = CAPTIONS_HintMapMovieClipCaption;
         }
         _loc6_ = _loc5_[_loc2_];
         this.FHintBtn.Caption = _loc6_;
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(this,this.FHintBtn);
         }
      }
      
      protected function BtnOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function AutoBattleOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = null;
         if(this.FHelpHintOnMove != null)
         {
            switch(param1.currentTarget)
            {
               case this.FMC_Active_AutoBattle:
                  _loc2_ = this.FHintAutoBattle;
                  break;
               case this.FMC_Active_AutoGoldResurgence:
                  _loc2_ = this.FHintAutoGoldResurgence;
                  break;
               case this.FMC_Active_AutoSkipResurgence:
                  _loc2_ = this.FHintAutoSkipResurgence;
            }
            this.FHelpHintOnMove(this,_loc2_);
         }
      }
      
      protected function AutoBattleOnOut(param1:MouseEvent) : void
      {
         if(this.FHelpHintOnOut != null)
         {
            this.FHelpHintOnOut(this);
         }
      }
      
      protected function OnAutoBattleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBtn_Active_AutoBattle:
               this.AutoBattleFun();
               break;
            case this.FBtn_Active_AutoGoldResurgence:
               if(this.FIsAutoGoldResurgence)
               {
                  this.AutoGoldFun();
                  return;
               }
               this.GoldOrSkip = 1;
               this.FUIWindowConfirmation.Text = STRING_SHORTCUTS.STRING_Auto_Gold;
               this.FUIWindowConfirmation.Visible = true;
               break;
            case this.FBtn_Active_AutoSkipResurgence:
               if(!this.SkipResurgenceBtnIsCanUse)
               {
                  return;
               }
               if(this.FIsAutoSkipResurgence || Boolean(SLogicsCore.Character.VipData.ArenaSkip))
               {
                  this.AutoSkip();
                  return;
               }
               this.GoldOrSkip = 2;
               this.FUIWindowConfirmation.Text = STRING_SHORTCUTS.STRING_Auto_Skip;
               this.FUIWindowConfirmation.Visible = true;
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object) : void
      {
         switch(this.GoldOrSkip)
         {
            case 1:
               this.AutoGoldFun();
               break;
            case 2:
               this.AutoSkip();
         }
      }
      
      protected function AutoBattleFun() : void
      {
         this.FIsAutoBattle = !this.FIsAutoBattle;
         this.FBtn_Active_AutoBattle.gotoAndStop(this.FIsAutoBattle ? TYPE_AutoBattle_Ok : TYPE_AutoBattle_Cancel);
         if(this.FAutoBattle != null)
         {
            this.FAutoBattle(this,this.FIsAutoBattle,this.FIsAutoGoldResurgence,this.FIsAutoSkipResurgence);
         }
      }
      
      protected function AutoGoldFun() : void
      {
         this.FIsAutoGoldResurgence = !this.FIsAutoGoldResurgence;
         this.FBtn_Active_AutoGoldResurgence.gotoAndStop(this.FIsAutoGoldResurgence ? TYPE_AutoBattle_Ok : TYPE_AutoBattle_Cancel);
         if(this.FAutoBattle != null)
         {
            this.FAutoBattle(this,this.FIsAutoBattle,this.FIsAutoGoldResurgence,this.FIsAutoSkipResurgence);
         }
      }
      
      protected function AutoSkip() : void
      {
         this.FIsAutoSkipResurgence = !this.FIsAutoSkipResurgence;
         this.FBtn_Active_AutoSkipResurgence.gotoAndStop(this.FIsAutoSkipResurgence ? TYPE_AutoBattle_Ok : TYPE_AutoBattle_Cancel);
         if(this.FAutoBattle != null)
         {
            this.FAutoBattle(this,this.FIsAutoBattle,this.FIsAutoGoldResurgence,this.FIsAutoSkipResurgence);
         }
      }
      
      public function get ShortcutWidth() : int
      {
         this.UpdateBounds();
         return this.FWidth;
      }
      
      public function get IsMainScene() : Boolean
      {
         if(!this.FIsInitialization)
         {
            return false;
         }
         return this.FMCEnterMap.visible;
      }
      
      public function get OffestWidth() : int
      {
         return this.FOffestWidth;
      }
      
      public function get OnWorldMap() : Function
      {
         return this.FOnWorldMap;
      }
      
      public function set OnWorldMap(param1:Function) : void
      {
         this.FOnWorldMap = param1;
      }
      
      public function get OnReturnHome() : Function
      {
         return this.FOnReturnHome;
      }
      
      public function set OnReturnHome(param1:Function) : void
      {
         this.FOnReturnHome = param1;
      }
      
      public function get OnViewRaiders() : Function
      {
         return this.FOnViewRaiders;
      }
      
      public function set OnViewRaiders(param1:Function) : void
      {
         this.FOnViewRaiders = param1;
      }
      
      public function get OnMail() : Function
      {
         return this.FOnMail;
      }
      
      public function set OnMail(param1:Function) : void
      {
         this.FOnMail = param1;
      }
      
      public function get OnQuest() : Function
      {
         return this.FOnQuest;
      }
      
      public function set OnQuest(param1:Function) : void
      {
         this.FOnQuest = param1;
      }
      
      public function get OnFriend() : Function
      {
         return this.FOnFriend;
      }
      
      public function set OnFriend(param1:Function) : void
      {
         this.FOnFriend = param1;
      }
      
      public function get OnSwitchDisplay() : Function
      {
         return this.FOnSwitchDisplay;
      }
      
      public function set OnSwitchDisplay(param1:Function) : void
      {
         this.FOnSwitchDisplay = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get HelpHintOnMove() : Function
      {
         return this.FHelpHintOnMove;
      }
      
      public function set HelpHintOnMove(param1:Function) : void
      {
         this.FHelpHintOnMove = param1;
      }
      
      public function get HelpHintOnOut() : Function
      {
         return this.FHelpHintOnOut;
      }
      
      public function set HelpHintOnOut(param1:Function) : void
      {
         this.FHelpHintOnOut = param1;
      }
      
      public function get AutoBattle() : Function
      {
         return this.FAutoBattle;
      }
      
      public function set AutoBattle(param1:Function) : void
      {
         this.FAutoBattle = param1;
      }
      
      public function get ZeroReq() : Function
      {
         return this.FZeroReq;
      }
      
      public function set ZeroReq(param1:Function) : void
      {
         this.FZeroReq = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
      }
      
      public function InitSystemSetup() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         _loc3_ = Boolean(SLogicsCore.AntiAddiction.SoundMute);
         if(_loc3_)
         {
            this.FMC_ESwitchSound.gotoAndStop(2);
            this.FMC_RSwitchSound.gotoAndStop(2);
            SMusicPlayer.Mute = _loc3_;
         }
      }
      
      public function Update() : void
      {
         this.UpdateEffectsGlow();
         this.UpdateTime();
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutMapModes) : void
      {
         var _loc2_:SimpleButton = null;
         var _loc3_:Boolean = false;
         var _loc6_:uint = 0;
         if(this.FIsInitialization == false)
         {
            return;
         }
         var _loc4_:int = this.FShortcutCapacity;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.GetShortcutModeByIndex(_loc5_);
            switch(_loc6_)
            {
               case TLobbyShortcutMode.SHORTCUTMODE_Show:
                  _loc3_ = true;
                  break;
               case TLobbyShortcutMode.SHORTCUTMODE_Hidden:
                  _loc3_ = false;
            }
            switch(_loc5_)
            {
               case TYPE_Map:
                  this.FMCEnterMap.visible = _loc3_;
                  break;
               case TYPE_ReturnHome:
                  this.FMCReturnHome.visible = _loc3_;
                  break;
               case TYPE_AutoBattle:
                  this.FMC_Active_AutoBattle.visible = _loc3_;
                  this.FMC_Active_AutoGoldResurgence.visible = _loc3_;
                  this.FMC_Active_AutoSkipResurgence.visible = _loc3_;
            }
            _loc5_++;
         }
      }
      
      public function UpdateReturnHomePanel(param1:String, param2:String) : void
      {
         this.ProcessorUpdateReturnHomePanel(param1,param2);
      }
      
      public function ShowEffectNotification(param1:uint, param2:Boolean) : void
      {
         this.ProcessorShortcutShowEffect(param1,param2);
      }
      
      public function ShowEffectNotificationCopy(param1:uint, param2:Boolean) : void
      {
         this.ProcessorShortcutShowEffectCopy(param1,param2);
      }
      
      public function SetAutoStatus(param1:Object, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         if(param2)
         {
            this.FBtn_Active_AutoBattle.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         if(param3)
         {
            this.FBtn_Active_AutoGoldResurgence.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         if(param4)
         {
            this.FBtn_Active_AutoSkipResurgence.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      public function EndAutoBattle(param1:Object) : void
      {
         this.FIsAutoBattle = false;
         this.FIsAutoGoldResurgence = false;
         this.FIsAutoSkipResurgence = false;
         this.FBtn_Active_AutoBattle.gotoAndStop(TYPE_AutoBattle_Cancel);
         this.FBtn_Active_AutoGoldResurgence.gotoAndStop(TYPE_AutoBattle_Cancel);
         this.FBtn_Active_AutoSkipResurgence.gotoAndStop(TYPE_AutoBattle_Cancel);
         if(this.FAutoBattle != null)
         {
            this.FAutoBattle(this,this.FIsAutoBattle,this.FIsAutoGoldResurgence,this.FIsAutoSkipResurgence);
         }
      }
      
      public function UpdateSkipResurgenceBtnfilter(param1:int) : void
      {
         if(param1 == 3)
         {
            this.FMC_Active_AutoGoldResurgence.visible = false;
         }
         else
         {
            this.FMC_Active_AutoGoldResurgence.visible = true;
         }
         if(this.GetSkipCardNum() > 0 || Boolean(SLogicsCore.Character.VipData.ArenaSkip))
         {
            this.setFilter(false);
         }
         else
         {
            this.setFilter(true);
         }
      }
      
      protected function setFilter(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC_Active_AutoSkipResurgence.filters = [TGameUtil.gBlackFilters];
            this.SkipResurgenceBtnIsCanUse = false;
            this.FIsAutoSkipResurgence = true;
            this.AutoSkip();
         }
         else
         {
            this.FMC_Active_AutoSkipResurgence.filters = [];
            this.SkipResurgenceBtnIsCanUse = true;
         }
      }
      
      protected function GetSkipCardNum() : uint
      {
         return SLogicsCore.Character.Appliances.GetAllCountByTempletID(CONST_BATTLE.BattleSkipCard);
      }
      
      public function ExecuteCommand(param1:Object = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = int(param1.type);
         var _loc3_:int = int(param1.value);
         switch(_loc2_)
         {
            case 1:
               if(_loc3_ == 1)
               {
                  this.FIsAutoBattle = false;
               }
               else
               {
                  this.FIsAutoBattle = true;
               }
               this.AutoBattleFun();
               break;
            case 2:
               if(_loc3_ == 1)
               {
                  this.FIsAutoGoldResurgence = false;
               }
               else
               {
                  this.FIsAutoGoldResurgence = true;
               }
               this.AutoGoldFun();
               break;
            case 3:
               if(_loc3_ == 1)
               {
                  this.FIsAutoSkipResurgence = false;
               }
               else
               {
                  this.FIsAutoSkipResurgence = true;
               }
               this.AutoSkip();
               break;
            case 4:
               if(_loc3_ == 3)
               {
                  this.FMC_Active_AutoGoldResurgence.visible = false;
               }
               else
               {
                  this.FMC_Active_AutoGoldResurgence.visible = true;
               }
         }
      }
   }
}


package Processors.Game.Lobby.NarutoHelper
{
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.ActivityMode.TActivityAtoms;
   import Logics.NarutoHelper.TQuestion;
   import Logics.NarutoHelper.TQuestions;
   import Logics.SLogicsCore;
   import Logics.Streamization.NarutoHelper.TUnstreamizerNarutoHelper;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.NarutoHelper.SecondaryWindow.TUINinjaLesson;
   import Processors.Game.Lobby.NarutoHelper.SecondaryWindow.TUIRecommendFunction;
   import Processors.Game.Lobby.NarutoHelper.SecondaryWindow.TUISecretQAndA;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NARUTOHELPER;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_NARUTOHELPER;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNarutoHelper extends TProcessorLobbyWindows
   {
      
      public const PosX_OffSet:uint = 190;
      
      public const PosY_OffSet:uint = 90;
      
      protected var FUIRecommendFunction:TUIRecommendFunction;
      
      protected var FUINinjaLesson:TUINinjaLesson;
      
      protected var FUISecretQAndA:TUISecretQAndA;
      
      protected var FMainUI:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FUIWindows:Vector.<TUIComponent>;
      
      protected var FUnstreamizerNarutoHelper:TUnstreamizerNarutoHelper;
      
      protected var FActivityAtoms:TActivityAtoms;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FOnEffectSign:Function;
      
      protected var FOnFirstRecharge:Function;
      
      public function TProcessorNarutoHelper(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUITab = new TUITab(this);
         this.FUIWindows = new Vector.<TUIComponent>();
         this.FUnstreamizerNarutoHelper = new TUnstreamizerNarutoHelper();
         SetUIModuleID(CONST_MODULES.MODULE_NarutoHelper);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_NARUTOHELPER.RESOURCESID_Swf_NARUTOHELPER);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FMainUI = TUtilityReflection.CreateDisplayObjectInstance("MC_NarutoHelper") as Sprite;
         addChild(this.FMainUI);
         this.FMainUI.x = (CONST_COMMON.STAGE_Width - this.FMainUI.width) / 2;
         this.FMainUI.y = (CONST_COMMON.STAGE_Height - this.FMainUI.height) / 2;
         this.FUIRecommendFunction = new TUIRecommendFunction(this);
         this.FUIRecommendFunction.ResourceUIDispatch(this.FMainUI["MC_RecommendFunction"]);
         this.FUIRecommendFunction.TextOnClick = this.ProcessorTextOnClick;
         this.FUIRecommendFunction.x = this.FMainUI.x;
         this.FUIRecommendFunction.y = this.FMainUI.y;
         this.FUINinjaLesson = new TUINinjaLesson(this);
         this.FUINinjaLesson.ResourceUIDispatch(this.FMainUI["MC_NinjaLesson"]);
         this.FUINinjaLesson.x = this.FMainUI.x;
         this.FUINinjaLesson.y = this.FMainUI.y;
         this.FUISecretQAndA = new TUISecretQAndA(this);
         this.FUISecretQAndA.AnswerOnClick = this.ProcessorAnswerOnClick;
         this.FUISecretQAndA.ResourceUIDispatch(this.FMainUI["MC_SecretQAndA"]);
         this.FUISecretQAndA.OnClose = this.ProcessorOnClose;
         this.FUISecretQAndA.x = this.FMainUI.x;
         this.FUISecretQAndA.y = this.FMainUI.y;
         this.FUIWindows.push(this.FUIRecommendFunction);
         this.FUIWindows.push(this.FUINinjaLesson);
         this.FUIWindows.push(this.FUISecretQAndA);
         _loc2_ = 3;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMainUI["MC_Tab_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc3_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FBTN_Close = this.FMainUI["BTN_Close"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FUnstreamizerNarutoHelper.UnstreamizeLevelRecommendNinjas(null,SLogicsCore.NarutoHelperData.LevelRecommendNinjas,null);
         this.FUnstreamizerNarutoHelper.UnstreamizeClassroom(null,SLogicsCore.NarutoHelperData.NinjaLessons,null);
         this.FUnstreamizerNarutoHelper.UnstreamizeQuestion(null,SLogicsCore.NarutoHelperData.Questions,null);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NarutoHelper_Progress_Ret,this.PacketPerform_SC_Progress_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NarutoHelper_Answer_Ret,this.PacketPerform_SC_Answer_Ret);
      }
      
      protected function PacketPerform_SC_Progress_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         SLogicsCore.NarutoHelperData.AnswerLevel = _loc2_.readUnsignedInt();
         _loc4_ = Boolean(_loc2_.readUnsignedInt());
         SLogicsCore.NarutoHelperData.IsHasQuestion = _loc4_;
         this.CheckIconEffect1();
         if(FIsResourcesLoadCompleted)
         {
            this.FUISecretQAndA.Update();
         }
      }
      
      protected function PacketPerform_SC_Answer_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:TQuestion = null;
         var _loc9_:TQuestions = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = "";
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc6_ = _loc2_.readUnsignedInt();
         SLogicsCore.NarutoHelperData.AnswerLevel = _loc6_;
         SLogicsCore.NarutoHelperData.IsHasQuestion = Boolean(_loc2_.readUnsignedInt());
         _loc9_ = SLogicsCore.NarutoHelperData.Questions;
         this.CheckIconEffect1();
         _loc5_ = _loc2_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            _loc4_ += TUtilityString.Format(STRING_NARUTOHELPER.FORMAT_GetSiliver,_loc5_);
         }
         _loc5_ = _loc2_.readUnsignedInt();
         if(_loc5_ != 0)
         {
            _loc4_ += TUtilityString.Format(STRING_NARUTOHELPER.FORMAT_GetGift,_loc5_);
         }
         _loc8_ = _loc9_.GetQuestionByLevel(_loc6_);
         _loc4_ += "\n" + _loc8_.Feedbacks[_loc7_ - 1];
         EffectGenerateText(_loc4_);
         if(FIsResourcesLoadCompleted)
         {
            this.FUISecretQAndA.Update();
         }
      }
      
      protected function CheckIconEffect1() : void
      {
         var _loc1_:TQuestion = null;
         var _loc2_:TQuestions = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         _loc3_ = uint(SLogicsCore.Character.GetMainLevel());
         _loc4_ = uint(SLogicsCore.NarutoHelperData.AnswerLevel);
         _loc2_ = SLogicsCore.NarutoHelperData.Questions;
         _loc5_ = Boolean(SLogicsCore.NarutoHelperData.IsHasQuestion);
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_NarutoHelper,_loc5_);
         }
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         this.ButtonCloseOnClick(null);
      }
      
      protected function ProcessorTextOnClick(param1:Object, param2:uint, param3:uint, param4:uint) : void
      {
         var _loc5_:TActivityAtom = null;
         var _loc6_:TActivityAtoms = null;
         this.ButtonCloseOnClick(null);
         if(param2 == CONST_SHORTCUTS.POSITION_ActiveList && param3 == CONST_SHORTCUTS.TYPE_ActiveList_FirstRecharge)
         {
            _loc6_ = SLogicsCore.ActivityModes.GetActivityAtomsByIdentifier(5);
            _loc5_ = _loc6_.GetActivityAtomByIndex(_loc6_.Count - 1);
            if(_loc5_.ActiveStatus == -1)
            {
               return;
            }
            if(this.FOnFirstRecharge != null)
            {
               this.FOnFirstRecharge(this);
            }
         }
         else if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,param2,param3,param4);
         }
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         this.FTabIndex = param1 as int;
         _loc3_ = this.FUIWindows.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FTabIndex != _loc2_)
            {
               this.FUIWindows[_loc2_].Visible = false;
            }
            _loc2_++;
         }
         this.FUIWindows[this.FTabIndex].Visible = true;
         this.FUIWindows[this.FTabIndex]["Update"]();
      }
      
      protected function ProcessorAnswerOnClick(param1:Object, param2:uint, param3:int) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoHelper_Answer_Req);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(param2);
         _loc5_.writeUnsignedInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function set OnFirstRecharge(param1:Function) : void
      {
         this.FOnFirstRecharge = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.Load();
            return;
         }
         this.FUITab.TabIndex = 1;
         this.FUITab.SwithTagManual(0);
         if(SLogicsCore.Character.GetMainLevel() > SLogicsCore.NarutoHelperData.AnswerLevel)
         {
            this.FUITab.SwithTagManual(2);
         }
         this.Visible = true;
      }
      
      public function LevelUpOpenIconEffect() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoHelper_Progress_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
   }
}


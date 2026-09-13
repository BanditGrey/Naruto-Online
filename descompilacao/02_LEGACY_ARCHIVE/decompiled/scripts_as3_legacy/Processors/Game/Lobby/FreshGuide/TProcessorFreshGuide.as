package Processors.Game.Lobby.FreshGuide
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Queries.Coordinate.*;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.FreshGuide.*;
   import Logics.Quests.*;
   import Logics.Signals.*;
   import Processors.Accessories.*;
   import Processors.Game.*;
   import Processors.Game.Common.*;
   import Processors.Game.Lobby.Arena.*;
   import Processors.Game.Lobby.BigDipper.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.CopyClassroom.*;
   import Processors.Game.Lobby.DailyQuest.*;
   import Processors.Game.Lobby.GeneralStar.*;
   import Processors.Game.Lobby.Heros.*;
   import Processors.Game.Lobby.KillHeros.*;
   import Processors.Game.Lobby.MainScene.*;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Processors.Game.Lobby.Pet.*;
   import Processors.Game.Lobby.Ramen.*;
   import Processors.Game.Lobby.Shortcuts.*;
   import Processors.Game.Lobby.Shortcuts.Window.*;
   import Processors.Game.Lobby.Sign.*;
   import Processors.Game.Lobby.Smithy.*;
   import Processors.Game.Lobby.SuperHero.*;
   import Processors.Game.Lobby.TacticalDeployment.*;
   import Processors.Game.Lobby.Talisman.*;
   import Processors.Game.Lobby.Tavern.*;
   import Processors.Game.Lobby.TreasureMap.TProcessorTreasureMap;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TProcessorFreshGuide extends TProcessorLobbyWindows
   {
      
      protected var FRESHGUIDE_BASEID:uint = 70500000;
      
      protected var FRESHGUIDE_ENDID:uint = 70500101;
      
      protected var HandleIndex_ShowWelcomeView:int = 1;
      
      protected var HandleIndex_AutoSearchWay:int = 2;
      
      protected var HandleIndex_AutoSetDeployment:int = 3;
      
      protected var HandleIndex_ShowFamilyView:int = 4;
      
      protected var HandleIndex_CompleteFreshGuide:int = 5;
      
      protected var Mode_FreshGuide:int = 0;
      
      protected var Mode_FunctionGuide:int = 1;
      
      protected var FCurrentMode:int;
      
      protected var FFreshSteps:Vector.<TFreshStep>;
      
      protected var FFreshGuideCoordinate:TCoordinate;
      
      protected var FWindowWelcome:TWindowWelcome;
      
      protected var FWindowFamily:TWindowFamily;
      
      protected var FPromptText:TextField;
      
      protected var FArrows:Vector.<TUIArrow>;
      
      protected var FMountPoints:Vector.<TProcessorMountPoint>;
      
      protected var FArrowRelationModule:Vector.<DisplayObjectContainer>;
      
      protected var FFreshGuideComplete:Boolean;
      
      protected var FHandleRoutine:TRegistryRoutine;
      
      protected var FStartFreshStep:Boolean;
      
      protected var FCurrentFreshSetep:uint;
      
      protected var FCurrentFreshSetepStore:uint;
      
      protected var FFunctionGuideJudgeStr:String;
      
      protected var QueryCoordinate:TQueryCoordinate;
      
      protected var FStepPosition:int;
      
      protected var FStepLocation:int;
      
      protected var FQuestGuide:DisplayObjectContainer;
      
      protected var FAutoSetDeployment:Function;
      
      protected var FAutoSearchWay:Function;
      
      protected var Counter:int;
      
      protected var FOnQueryShortcutCoordinate:Function;
      
      protected var FOnActivatingChannel:Function;
      
      public function TProcessorFreshGuide(param1:TProcessorMountPoint, param2:TProcessorMountPoint, param3:TProcessorMountPoint, param4:TProcessorMountPoint, param5:TLobbyParameters)
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TUIArrow = null;
         super(param3,param5);
         this.FWindowWelcome = new TWindowWelcome(this);
         this.FWindowWelcome.visible = false;
         this.FWindowWelcome.OnClickBtn = this.DeleteBarrier;
         this.FWindowWelcome.Load();
         this.FWindowFamily = new TWindowFamily(this);
         this.FWindowFamily.visible = false;
         this.FWindowFamily.OnClickBtn = this.DeleteBarrier;
         this.FWindowFamily.OnEffectText = ProcessorsOnEffectText;
         this.FWindowFamily.OnHintMove = this.UIComponentsApplianceOnOver;
         this.FWindowFamily.OnHintOut = this.UIComponentsApplianceOnOut;
         this.FFreshSteps = new Vector.<TFreshStep>();
         this.FMountPoints = new Vector.<TProcessorMountPoint>();
         this.FMountPoints.push(param1);
         this.FMountPoints.push(param2);
         this.FMountPoints.push(param4);
         this.FArrows = new Vector.<TUIArrow>();
         this.FArrows.push(new TUIArrow(param1));
         this.FArrows.push(new TUIArrow(param2));
         this.FArrows.push(new TUIArrow(param4));
         this.HideAllMountPoint();
         this.FArrowRelationModule = new Vector.<DisplayObjectContainer>(26);
         this.FArrowRelationModule[1] = this.FWindowWelcome;
         this.FArrowRelationModule[11] = this.FWindowFamily;
         this.FFreshGuideCoordinate = new TCoordinate();
         this.FFreshGuideCoordinate.X = CONST_FRESHGUIDE.TASK_GUIDE_ARROW_X;
         this.FFreshGuideCoordinate.Y = CONST_FRESHGUIDE.TASK_GUIDE_ARROW_Y;
         this.ConstructPromptWindow();
         this.FHandleRoutine = new TRegistryRoutine();
         this.FHandleRoutine.Register(this.HandleIndex_ShowWelcomeView,this.Special_ShowWelcomeView);
         this.FHandleRoutine.Register(this.HandleIndex_AutoSearchWay,this.Special_AutoSearchWay);
         this.FHandleRoutine.Register(this.HandleIndex_AutoSetDeployment,this.Special_AutoSetDeployment);
         this.FHandleRoutine.Register(this.HandleIndex_ShowFamilyView,this.Special_ShowFamilyView);
         this.FHandleRoutine.Register(this.HandleIndex_CompleteFreshGuide,this.Special_CompleteFreshGuide);
         _loc7_ = int(this.FArrows.length);
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = this.FArrows[_loc6_];
            _loc8_.Load();
            _loc6_++;
         }
         this.QueryCoordinate = new TQueryCoordinate();
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      protected function ConstructPromptWindow() : void
      {
         this.FPromptText = new TextField();
         this.FPromptText.autoSize = TextFieldAutoSize.CENTER;
         this.FPromptText.textColor = 65280;
         this.FPromptText.scaleX = 5;
         this.FPromptText.scaleY = 5;
         this.FPromptText.x = 600;
      }
      
      protected function ConstructFreshGuideStep() : void
      {
         var _loc1_:TBins = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TNewGuide = null;
         var _loc5_:TFreshStep = null;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewGuide);
         this.FFreshSteps.push(null);
         _loc3_ = _loc1_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc1_.GetDatebaseByIndex(_loc2_) as TNewGuide;
            _loc5_ = new TFreshStep(_loc4_.Identifier);
            _loc5_.ArrowPosition.X = _loc4_.ArrowX;
            _loc5_.ArrowPosition.Y = _loc4_.ArrowY;
            _loc5_.Message = _loc4_.GuideMessage;
            _loc5_.TriggerCode = _loc4_.TriggerIndex;
            _loc5_.IfAlreadyTrigger = false;
            _loc5_.IfAutoTrigger = _loc4_.AutoTrigger;
            _loc5_.CompleteCode = _loc4_.CompleteIndex;
            _loc5_.IfKeyNode = _loc4_.IfKeyNode;
            _loc5_.KeyNodeCompleteProgress = _loc4_.SendIndex;
            _loc5_.NextTaskIdentifier = _loc4_.NextTaskID;
            _loc5_.RelationLayer = _loc4_.RelationLayer;
            _loc5_.RelationModule = _loc4_.RelationModule;
            _loc5_.TelesportCode = _loc4_.TelesportCode;
            _loc5_.TelesportTargetID = _loc4_.TelesportTargetID;
            _loc5_.SpecialHandleID = _loc4_.SpecialHandleID;
            this.FFreshSteps.push(_loc5_);
            _loc2_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.ConstructFreshGuideStep();
         this.HideAllMountPoint();
         FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_FreshGuide);
         FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FreshGuide_PunyFamilyRet,this.PerformPacket_SC_PunyFamilyRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_FreshGuide_Step2ReadRet,this.PerformPacket_SC_Step2ReadRet);
      }
      
      protected function PerformPacket_SC_PunyFamilyRet(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedByte();
         this.FWindowFamily.SetPunyFamily(_loc4_);
      }
      
      protected function PerformPacket_SC_Step2ReadRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         SLogicsCore.AutoFightString = _loc2_.readUTF();
      }
      
      protected function HandleEventCode(param1:int) : void
      {
         var _loc2_:TFreshStep = null;
         _loc2_ = this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID];
         if(_loc2_.CompleteCode == param1)
         {
            this.CompleteCurrentStep();
            this.FCurrentFreshSetep = _loc2_.NextTaskIdentifier;
         }
         else if(_loc2_.TelesportCode == param1)
         {
            this.FCurrentFreshSetep = _loc2_.TelesportTargetID;
            this.IntoNextFreshGuide();
         }
      }
      
      protected function CompleteCurrentStep() : void
      {
         var _loc1_:TFreshStep = null;
         _loc1_ = this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID];
         if(_loc1_.IfKeyNode)
         {
            this.SendCompleteMessageToServer(_loc1_.KeyNodeCompleteProgress);
         }
         this.HideAllMountPoint();
         this.FArrows[_loc1_.RelationLayer].visible = false;
      }
      
      protected function SendCompleteMessageToServer(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:String = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FreshGuide_CompleteStepReq);
         _loc3_ = TUtilityString.Format(CONST_FRESHGUIDE.FormatString_FreshGuide,param1.toString(),this.FFunctionGuideJudgeStr);
         TUtilityString.FlushUTF(_loc2_.Data,_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FCurrentFreshSetepStore = param1;
      }
      
      protected function UpdateGuideMessageToServer() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:String = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_FreshGuide_CompleteStepReq);
         _loc2_ = TUtilityString.Format(CONST_FRESHGUIDE.FormatString_FreshGuide,this.FCurrentFreshSetepStore.toString(),this.FFunctionGuideJudgeStr);
         TUtilityString.FlushUTF(_loc1_.Data,_loc2_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function CheckIfTriggerFreshGuideTask(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:TFreshStep = null;
         _loc2_ = this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID;
         _loc3_ = this.FFreshSteps[_loc2_];
         if(_loc3_.TriggerCode == param1)
         {
            return true;
         }
         return false;
      }
      
      protected function GetRepositionID(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<int> = null;
         _loc3_ = CONST_FRESHGUIDE.IDNeedReposition;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      protected function IntoNextFreshGuide() : void
      {
         var _loc1_:TFreshStep = null;
         var _loc2_:Function = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         _loc1_ = this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID];
         _loc4_ = this.GetRepositionID(_loc1_.Identifier);
         if(_loc4_ != -1)
         {
            if(this.FOnQueryShortcutCoordinate != null)
            {
               _loc5_ = CONST_FRESHGUIDE.IDNeedRepositionPositionAndLocation;
               this.FOnQueryShortcutCoordinate(this,_loc5_[_loc4_ << 1],_loc5_[(_loc4_ << 1) + 1],this.QueryCoordinate);
               _loc1_.ArrowPosition.X = this.QueryCoordinate.Value.X - 10;
               _loc1_.ArrowPosition.Y = this.QueryCoordinate.Value.Y;
            }
         }
         _loc1_.IfAlreadyTrigger = true;
         this.ResetArrow();
         _loc2_ = this.FHandleRoutine.GetRoutineByIndentifier(_loc1_.SpecialHandleID);
         if(_loc2_ != null)
         {
            _loc2_();
         }
         this.FPromptText.text = this.FCurrentFreshSetep.toString();
      }
      
      protected function ResetArrow() : void
      {
         var _loc1_:TFreshStep = null;
         var _loc2_:TCoordinate = null;
         _loc1_ = this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID];
         _loc2_ = _loc1_.ArrowPosition;
         this.FArrows[_loc1_.RelationLayer].SetArrowInfor(this.FArrowRelationModule[_loc1_.RelationModule],_loc2_,_loc1_.Message);
         this.HideAllMountPoint();
         if(!(_loc2_.X == 0 && _loc2_.Y == 0))
         {
            this.FMountPoints[_loc1_.RelationLayer].visible = true;
            this.FArrows[_loc1_.RelationLayer].visible = true;
         }
      }
      
      protected function Special_ShowWelcomeView() : void
      {
         BarrierActuate(this.FWindowWelcome);
         this.FWindowWelcome.visible = true;
      }
      
      protected function Special_AutoSearchWay() : void
      {
         if(this.FAutoSearchWay != null)
         {
            this.FAutoSearchWay();
         }
      }
      
      protected function Special_AutoSetDeployment() : void
      {
         if(this.FAutoSetDeployment != null)
         {
            this.FAutoSetDeployment(11100101,1,null);
         }
      }
      
      protected function Special_ShowFamilyView() : void
      {
         BarrierActuate(this.FWindowFamily);
         this.FWindowFamily.Visible = true;
      }
      
      protected function Special_CompleteFreshGuide() : void
      {
         this.FFreshGuideComplete = true;
         this.HideAllMountPoint();
         this.SendCompleteMessageToServer(this.FRESHGUIDE_ENDID);
         EffectGenerateText(STRING_COMMON.STRING_PassFreshGuide);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TFreshStep = null;
         super.LogicsPerform();
         this.LogicsPerform_Signals();
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:Boolean = false;
         while(true)
         {
            _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_LobbyTutorial);
            if(_loc1_ == null)
            {
               break;
            }
            switch(this.FCurrentMode)
            {
               case this.Mode_FreshGuide:
               case this.Mode_FunctionGuide:
                  _loc2_ = this.FunctionFirstUseGuide(_loc1_.Identifier);
                  if(!_loc2_)
                  {
                     this.NotifyFreshGuideEventHappen(_loc1_.Identifier);
                  }
            }
         }
      }
      
      protected function UIComponentsApplianceOnOver(param1:Object, param2:Object) : void
      {
         if(FOverlayerAppliance != null)
         {
            FOverlayerAppliance.Context = param2;
            FOverlayerAppliance.Render(FUICore.MouseCoordinate);
            FOverlayerAppliance.Show();
         }
      }
      
      protected function UIComponentsApplianceOnOut(param1:Object) : void
      {
         if(FOverlayerAppliance != null)
         {
            FOverlayerAppliance.Hide();
         }
      }
      
      protected function DeleteBarrier(param1:Object) : void
      {
         BarrierDeactuate(param1);
      }
      
      public function SetRelationModule(param1:DisplayObjectContainer) : void
      {
         if(param1 is TUIRoleNpc)
         {
            this.FArrowRelationModule[0] = param1;
         }
         else if(param1 is TWindowWelcome)
         {
            this.FArrowRelationModule[1] = param1;
         }
         else if(param1 is TLayerNpcDialog)
         {
            this.FArrowRelationModule[2] = param1;
         }
         else if(param1 is TWindowQuestGuide)
         {
            this.FArrowRelationModule[3] = param1;
         }
         else if(param1 is TProcessorWindowHeros)
         {
            this.FArrowRelationModule[5] = param1;
         }
         else if(param1 is TProcessorWindowTacticalDeployment)
         {
            this.FArrowRelationModule[6] = param1;
         }
         else if(param1 is TProcessorWindowSmithy)
         {
            this.FArrowRelationModule[7] = param1;
         }
         else if(param1 is TProcessorWindowPetLevel)
         {
            this.FArrowRelationModule[8] = param1;
         }
         else if(param1 is TProcessorWindowEsoteric)
         {
            this.FArrowRelationModule[9] = param1;
         }
         else if(param1 is TProcessorShortcuts)
         {
            this.FArrowRelationModule[10] = param1;
         }
         else if(param1 is TProcessorMountPoint)
         {
            this.FArrowRelationModule[12] = param1;
         }
         else if(param1 is TProcessorWindowBigDipper)
         {
            this.FArrowRelationModule[13] = param1;
            this.FArrowRelationModule[20] = param1;
         }
         else if(param1 is TProcessorWindowTalisman)
         {
            this.FArrowRelationModule[14] = param1;
         }
         else if(param1 is TProcessorWindowKillHeros)
         {
            this.FArrowRelationModule[15] = param1;
         }
         else if(param1 is TProcessorWindowDailySign)
         {
            this.FArrowRelationModule[16] = param1;
         }
         else if(param1 is TProcessorTavern)
         {
            this.FArrowRelationModule[17] = param1;
         }
         else if(param1 is TProcessorArena)
         {
            this.FArrowRelationModule[18] = param1;
         }
         else if(param1 is TProcessorResourcesVital)
         {
            this.FArrowRelationModule[19] = param1;
         }
         else if(param1 is TProcessorWindowBigDipper)
         {
            this.FArrowRelationModule[20] = param1;
            this.FArrowRelationModule[13] = param1;
         }
         else if(param1 is TProcessorTreasureMap)
         {
            this.FArrowRelationModule[21] = param1;
         }
         else if(param1 is TProcessorWindowSuperHero)
         {
            this.FArrowRelationModule[22] = param1;
         }
         else if(param1 is TProcessorWindowTask)
         {
            this.FArrowRelationModule[23] = param1;
         }
         else if(param1 is TProcessorWindowCopyClassroom)
         {
            this.FArrowRelationModule[24] = param1;
         }
         else if(param1 is TProcessorWindowRamen)
         {
            this.FArrowRelationModule[25] = param1;
         }
      }
      
      public function HideAllMountPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TProcessorMountPoint = null;
         _loc2_ = int(this.FMountPoints.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FArrows[_loc1_].visible = false;
            _loc3_ = this.FMountPoints[_loc1_];
            _loc3_.visible = false;
            _loc1_++;
         }
      }
      
      public function NotifyFunctionGuideEventHappen(param1:int) : void
      {
         this.HandleEventCode(param1);
         if(this.CheckIfTriggerFreshGuideTask(param1))
         {
            this.IntoNextFreshGuide();
         }
      }
      
      public function NotifyFreshGuideEventHappen(param1:int) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         if(!this.FStartFreshStep)
         {
            return;
         }
         this.HandleEventCode(param1);
         if(this.CheckIfTriggerFreshGuideTask(param1))
         {
            this.IntoNextFreshGuide();
         }
      }
      
      public function CheckLoadResource() : void
      {
         if(this.FCurrentFreshSetep == 0)
         {
         }
         if(SLogicsCore.Character.Country == 0)
         {
            this.FWindowFamily.Load();
         }
      }
      
      public function StartFreshGuideTask() : void
      {
         var _loc1_:TFreshStep = null;
         var _loc2_:int = 0;
         var _loc3_:TQuest = null;
         if(SLogicsCore.Character.FreshGuideProgress == "0")
         {
            this.FCurrentFreshSetep = 0;
            this.FFunctionGuideJudgeStr = CONST_FRESHGUIDE.FunctionGuideInitString;
         }
         else
         {
            _loc2_ = int(SLogicsCore.Character.FreshGuideProgress.indexOf(CONST_FRESHGUIDE.FreshGuideSeparationChar));
            this.FCurrentFreshSetep = uint(SLogicsCore.Character.FreshGuideProgress.substring(0,_loc2_));
            this.FFunctionGuideJudgeStr = SLogicsCore.Character.FreshGuideProgress.substring(_loc2_ + 1);
         }
         this.FCurrentFreshSetepStore = this.FCurrentFreshSetep;
         this.CheckLoadResource();
         _loc3_ = SLogicsCore.Character.MainQuestComplete.GetQuestByIdentifier(16100023);
         if(_loc3_ != null)
         {
            if(SLogicsCore.Character.Country == 0)
            {
               this.FCurrentFreshSetep = 70500100;
               this.IntoNextFreshGuide();
            }
            else if(this.FOnActivatingChannel != null)
            {
               this.FOnActivatingChannel(this,CONST_CHAT.CHANNEL_TYPE_Country,true);
            }
         }
         else if(this.FCurrentFreshSetep < this.FRESHGUIDE_ENDID)
         {
            if(this.FCurrentFreshSetep == 0)
            {
               this.FCurrentFreshSetep = this.FRESHGUIDE_BASEID;
            }
            ++this.FCurrentFreshSetep;
            this.IntoNextFreshGuide();
         }
         this.FStartFreshStep = true;
      }
      
      public function SendFreshGuideNpc(param1:TUIRoleNpc) : void
      {
         this.SetRelationModule(param1);
      }
      
      public function set AutoSetDeployment(param1:Function) : void
      {
         this.FAutoSetDeployment = param1;
      }
      
      public function get AutoSetDeployment() : Function
      {
         return this.FAutoSetDeployment;
      }
      
      public function set AutoSearchWay(param1:Function) : void
      {
         this.FAutoSearchWay = param1;
      }
      
      public function set OnQueryShortcutCoordinate(param1:Function) : void
      {
         this.FOnQueryShortcutCoordinate = param1;
      }
      
      public function set OnActivatingChannel(param1:Function) : void
      {
         this.FOnActivatingChannel = param1;
      }
      
      public function StartFreshGuide() : void
      {
         this.StartFreshGuideTask();
      }
      
      public function EnterOtherScene() : void
      {
         this.FMountPoints[0].visible = false;
         this.FMountPoints[1].visible = false;
         this.FMountPoints[2].visible = false;
      }
      
      public function EnterCityScene() : void
      {
      }
      
      public function FreshGuideCompleteQuest(param1:TQuest) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<int> = null;
         _loc3_ = CONST_FRESHGUIDE.CompleteTaskHandlePoint;
         _loc2_ = _loc3_.indexOf(param1.Identifier);
         if(_loc2_ >= 0)
         {
            this.FCurrentFreshSetep = CONST_FRESHGUIDE.CompleteTaskTriggerFreshTaskID[_loc2_];
            this.IntoNextFreshGuide();
         }
      }
      
      public function UnlockNewFunction(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:Vector.<int> = null;
         var _loc6_:int = 0;
         if(this.FFunctionGuideJudgeStr == null)
         {
            return;
         }
         switch(param1)
         {
            case CONST_SHORTCUTS.POSITION_Function:
               _loc4_ = CONST_SHORTCUTS.FUNCTIONS_TYPE;
               _loc5_ = CONST_FRESHGUIDE.AppearNewFunctionTriggerFreshTaskID;
               break;
            case CONST_SHORTCUTS.POSITION_Activity:
               _loc4_ = CONST_SHORTCUTS.ACTIVITYS_TYPE;
               _loc5_ = CONST_FRESHGUIDE.AppearNewActivityFunctionTriggerFreshTaskID;
               break;
            case CONST_SHORTCUTS.POSITION_Constantly:
               _loc4_ = CONST_FRESHGUIDE.CONSTANLY_TYPE;
               _loc5_ = CONST_FRESHGUIDE.AppearNewConstanlyFunctionTriggerFreshTaskID;
               break;
            case CONST_FRESHGUIDE.POSITION_Common:
               _loc4_ = CONST_FRESHGUIDE.Common_TYPE;
               _loc5_ = CONST_FRESHGUIDE.AppearNewCommonFunctionTriggerFreshTaskID;
         }
         _loc3_ = _loc4_.indexOf(param2);
         if(_loc3_ >= 0)
         {
            _loc6_ = _loc5_[_loc3_];
            if(_loc6_ != 0)
            {
               this.FOnQueryShortcutCoordinate(this,param1,param2,this.QueryCoordinate);
               this.FStepPosition = param1;
               this.FStepLocation = param2;
               this.FCurrentFreshSetep = _loc6_;
               this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID].ArrowPosition.Y = this.QueryCoordinate.Value.Y;
               if(param1 == CONST_SHORTCUTS.POSITION_Activity)
               {
                  this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID].ArrowPosition.X = this.QueryCoordinate.Value.X - 10;
               }
               else
               {
                  this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID].ArrowPosition.X = this.QueryCoordinate.Value.X - 10;
               }
               this.IntoNextFreshGuide();
            }
            else
            {
               if(this.FStepPosition != 2 && this.FStepLocation != 1)
               {
                  return;
               }
               this.FOnQueryShortcutCoordinate(this,this.FStepPosition,this.FStepLocation,this.QueryCoordinate);
               this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID].ArrowPosition.Y = this.QueryCoordinate.Value.Y;
               if(param1 == CONST_SHORTCUTS.POSITION_Activity)
               {
                  this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID].ArrowPosition.X = this.QueryCoordinate.Value.X - 10;
               }
               else
               {
                  this.FFreshSteps[this.FCurrentFreshSetep - this.FRESHGUIDE_BASEID].ArrowPosition.X = this.QueryCoordinate.Value.X - 10;
               }
            }
         }
      }
      
      public function FunctionFirstUseGuide(param1:int) : Boolean
      {
         var _loc2_:Vector.<int> = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(this.FFunctionGuideJudgeStr == null)
         {
            return false;
         }
         _loc2_ = CONST_FRESHGUIDE.FunctionGuideID_Array;
         _loc3_ = _loc2_.indexOf(param1);
         _loc4_ = this.FFunctionGuideJudgeStr.charAt(_loc3_) == "0";
         if(_loc4_)
         {
            this.FCurrentMode = this.Mode_FunctionGuide;
            this.FCurrentFreshSetep = CONST_FRESHGUIDE.FunctionGuideTriggerTaskID[_loc3_];
            this.FFunctionGuideJudgeStr = this.FFunctionGuideJudgeStr.substring(0,_loc3_) + "1" + this.FFunctionGuideJudgeStr.substring(_loc3_ + 1);
            this.UpdateGuideMessageToServer();
            this.IntoNextFreshGuide();
            return true;
         }
         return false;
      }
      
      public function UpdateFamily() : void
      {
         this.FWindowFamily.UpdateFamily();
         this.FOnActivatingChannel(this,CONST_CHAT.CHANNEL_TYPE_Country,true);
      }
   }
}


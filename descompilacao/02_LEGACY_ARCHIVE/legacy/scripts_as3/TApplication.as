package
{
   import Debugging.*;
   import Externals.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Queries.Textures.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.System.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Foundation.Worker.SMainWorker;
   import Foundation.Worker.SWorker;
   import Foundation.Worker.WorkerCompat;
   import Logics.*;
   import Logics.Agent.*;
   import Logics.Agent.Spaces.*;
   import Processors.*;
   import Processors.Accessories.*;
   import Processors.Accessories.Logger.*;
   import Processors.Accessories.Performance.*;
   import Processors.Game.*;
   import Processors.Game.LodingGame.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.system.Security;
   import flash.ui.*;
   import flash.utils.*;
   
   use namespace ParametersSpace;
   
   public class TApplication extends MovieClip
   {
      
      protected var FApplicationInitialized:Boolean;
      
      protected var FParametersInitialized:Boolean;
      
      protected var FUICore:TUICore;
      
      protected var FUIRoot:TUIRoot;
      
      protected var FProcessorResourcesVital:TProcessorResourcesVital;
      
      protected var FProcessorLoading:TProcessorLoading;
      
      protected var FProcessorGameRoot:TProcessorGameRoot;
      
      protected var FProcessorLogger:TProcessorLogger;
      
      protected var FProcessorPerformance:TProcessorPerformance;
      
      protected var FLoadingGame:TLoadingLittleGame;
      
      protected var FMaskSubstrate:Sprite;
      
      protected var FRightMenu:TRightMenu;
      
      protected var FResourcesTimer:Timer;
      
      protected var FGarbageCollector:TGarbageCollector;
      
      protected var FTimeID:uint;
      
      protected var FIsUnload:Boolean;
      
      public function TApplication()
      {
         var _loc1_:Boolean = false;
         super();
         if(stage != null)
         {
            this.Hack();
         }
         _loc1_ = WorkerCompat.WorkersSupported;
         if(_loc1_)
         {
            if(WorkerCompat.Worker.current.isPrimordial)
            {
               addEventListener(Event.ADDED,this.ApplicationOnAdded);
               addEventListener(Event.ENTER_FRAME,this.StageOnEnterFrame);
               if(CONST_COMMON.USABLE_WORKER)
               {
                  this.InitWorker();
               }
            }
            else
            {
               stage.frameRate = CONST_COMMON.STAGE_FrameRate / 2;
               SWorker.InitWorker();
            }
         }
         else
         {
            addEventListener(Event.ADDED,this.ApplicationOnAdded);
            addEventListener(Event.ENTER_FRAME,this.StageOnEnterFrame);
         }
      }
      
      protected function InitWorker() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         _loc1_ = WorkerCompat.WorkerDomain.current.createWorker(this.loaderInfo.bytes);
         _loc2_ = WorkerCompat.Worker.current.createMessageChannel(_loc1_);
         _loc3_ = _loc1_.createMessageChannel(WorkerCompat.Worker.current);
         SMainWorker.MainWorker = _loc1_;
         SMainWorker.MainToBack = _loc2_;
         SMainWorker.BackToMain = _loc3_;
         SMainWorker.InitWorker();
         _loc1_.setSharedProperty(CONST_WORKER.SHARED_BackToMain,_loc3_);
         _loc1_.setSharedProperty(CONST_WORKER.SHARED_MainToBack,_loc2_);
         _loc1_.start();
      }
      
      protected function Hack() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         _loc1_ = this.numChildren;
         _loc2_ = int(_loc1_ - 1);
         while(_loc2_ >= 0)
         {
            this.removeChildAt(_loc2_);
            _loc2_--;
         }
      }
      
      protected function Initialize() : void
      {
         this.Initialize_Resize();
         this.Initialize_Parameters(root.loaderInfo.parameters);
         this.Initialize_Display();
         this.Initialize_Cores();
         this.Initialize_UISystem();
         this.Initialize_Processors();
         this.Initialize_Mask();
         this.Initialize_ResourcesTimer();
         this.Initialize_GarbageCollector();
         SExternalCore.BrazilLog(2);
         this.FApplicationInitialized = true;
      }
      
      protected function Initialize_Resize() : void
      {
         stage.addEventListener(Event.RESIZE,this.StageOnResize);
      }
      
      protected function Initialize_Parameters(param1:Object) : void
      {
         if(!this.FParametersInitialized)
         {
            Security.allowDomain("*");
            if(!SParametersCore.IsInitialization)
            {
               SParametersCore.CoerceProperties(param1);
            }
            this.FParametersInitialized = true;
         }
      }
      
      protected function Initialize_Display() : void
      {
         var _loc1_:Sprite = null;
         stage.align = StageAlign.TOP_LEFT;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.quality = StageQuality.HIGH;
         stage.frameRate = CONST_COMMON.STAGE_FrameRate;
         this.FRightMenu = new TRightMenu();
         this.FRightMenu.OnCopyDebugInfo = this.ProcessorOnCopyDebugInfo;
         _loc1_ = this.stage.getChildAt(0) as Sprite;
         _loc1_.contextMenu = this.FRightMenu.MyContextMenu;
         stage.showDefaultContextMenu = false;
      }
      
      protected function Initialize_Cores() : void
      {
         this.FUICore = new TUICore(stage);
      }
      
      protected function Initialize_UISystem() : void
      {
         this.FUIRoot = new TUIRoot(this.FUICore);
         this.FUIRoot.OnQuerySequenceCursor = this.UIRootOnQuerySequenceCursor;
      }
      
      protected function Initialize_Processors() : void
      {
         var _loc1_:int = Math.random() * STRING_LOBBY.RESOURCESID_Textures_StartLoading.length;
         var _loc2_:uint = uint(CONST_PLATE.GetStartLoadingID(_loc1_));
         this.FProcessorResourcesVital = new TProcessorResourcesVital(this.FUIRoot);
         this.FProcessorResourcesVital.LoadingPictureId = _loc2_;
         this.FProcessorLoading = new TProcessorLoading(this.FUIRoot);
         this.FProcessorLoading.OnLoadingCompleted = this.ProcessorOnLoadingCompleted;
         this.FProcessorLoading.LoadingPictureId = _loc2_;
         this.FLoadingGame = new TLoadingLittleGame(this.FUIRoot);
         this.FLoadingGame.LoadResources();
         this.FLoadingGame.visible = true;
         this.FProcessorGameRoot = new TProcessorGameRoot(this.FUIRoot);
         this.FProcessorGameRoot.OnGarbageCollector = this.ProcessorOnGarbageCollector;
         this.FProcessorGameRoot.Load();
         this.FProcessorGameRoot.Visible = false;
         this.FProcessorPerformance = new TProcessorPerformance(this.FUIRoot);
         this.FProcessorPerformance.Visible = false;
         this.FProcessorLogger = new TProcessorLogger(this.FUIRoot);
         this.FProcessorLogger.Visible = false;
         this.FProcessorLogger.IsEnabled = false;
         SResourcesCore.OnGarbageCollector = this.ProcessorOnGarbageCollector;
      }
      
      protected function Initialize_Mask() : void
      {
         this.FMaskSubstrate = new Sprite();
         this.FMaskSubstrate.graphics.lineStyle(0,0,0);
         this.FMaskSubstrate.graphics.beginFill(0,0);
         this.FMaskSubstrate.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.FMaskSubstrate.graphics.endFill();
         this.FUIRoot.addChild(this.FMaskSubstrate);
         this.FProcessorGameRoot.mask = this.FMaskSubstrate;
         this.FMaskSubstrate.mouseEnabled = false;
      }
      
      protected function Initialize_GarbageCollector() : void
      {
         this.FGarbageCollector = new TGarbageCollector();
         this.FGarbageCollector.Interval = 120002;
      }
      
      protected function Initialize_ResourcesTimer() : void
      {
         this.FResourcesTimer = new Timer(0);
         this.FResourcesTimer.addEventListener(TimerEvent.TIMER,this.ResourcesTimerOnTimer);
         this.FResourcesTimer.start();
      }
      
      protected function Update() : void
      {
         this.Update_Cores();
      }
      
      protected function Update_Cores() : void
      {
         STimingCore.Update();
         SResourcesCore.Update();
         SNetworkCore.Update();
         SLogicsCore.Update();
         this.FUICore.Update();
      }
      
      protected function Process() : void
      {
         this.Process_Resources();
         this.Process_Network();
         this.Process_Logics();
         this.Process_Rendering();
         this.FGarbageCollector.Process();
      }
      
      protected function Process_Resources() : void
      {
         this.FProcessorResourcesVital.ResourcesProcess();
         if(!this.FProcessorResourcesVital.ResourcesReady)
         {
            return;
         }
         if(this.FProcessorLoading != null)
         {
            this.FProcessorLoading.ResourcesProcess();
         }
         this.FProcessorGameRoot.ResourcesProcess();
      }
      
      protected function Process_Network() : void
      {
         var _loc1_:TTransceiver = null;
         var _loc2_:TPacket = null;
         _loc1_ = SNetworkCore.Transceiver;
         while(_loc1_.ReceivedPacketCount > 0)
         {
            _loc2_ = _loc1_.PacketReceive();
            this.FProcessorGameRoot.PacketProcess(_loc2_);
         }
      }
      
      protected function Process_Logics() : void
      {
         if(this.FProcessorLoading != null)
         {
            this.FProcessorLoading.LogicsProcess();
         }
         this.FProcessorGameRoot.LogicsProcess();
         this.FProcessorPerformance.Process();
         this.FProcessorLogger.LogicsProcess();
      }
      
      protected function Process_Rendering() : void
      {
         this.FUIRoot.Render();
      }
      
      protected function ProcessorLoadingDispose() : void
      {
         clearTimeout(this.FTimeID);
         if(this.FProcessorLoading != null)
         {
            if(this.FProcessorLoading.parent != null)
            {
               this.FProcessorLoading.parent.removeChild(this.FProcessorLoading);
            }
            this.FProcessorLoading.Visible = false;
            this.FProcessorLoading.Dispose();
            this.FProcessorLoading.OnLoadingCompleted = null;
            this.FProcessorLoading = null;
         }
      }
      
      protected function ApplicationOnAdded(param1:Event) : void
      {
         this.Hack();
      }
      
      protected function StageOnResize(param1:Event) : void
      {
         if(this.FUICore != null)
         {
            this.FUICore.UpdateStageSize();
         }
         if(this.FProcessorGameRoot != null)
         {
            this.FProcessorGameRoot.ProcessorProcess();
         }
      }
      
      protected function ResourcesTimerOnTimer(param1:TimerEvent) : void
      {
         SResourcesCore.Update();
      }
      
      protected function StageOnEnterFrame(param1:Event) : void
      {
         if(stage == null)
         {
            return;
         }
         if(!this.FApplicationInitialized)
         {
            this.Initialize();
         }
         this.Update();
         this.Process();
         if(this.FIsUnload)
         {
            if(this.FLoadingGame.alpha > 0)
            {
               this.FLoadingGame.alpha -= 0.01;
            }
            else
            {
               this.FIsUnload = false;
               this.FLoadingGame.UnloadLoadingGame();
               this.FLoadingGame.parent.removeChild(this.FLoadingGame);
            }
         }
      }
      
      protected function ProcessorOnLoadingCompleted(param1:Object) : void
      {
         if(this.FTimeID == 0)
         {
            this.FTimeID = setTimeout(this.ProcessorLoadingDispose,2000);
            this.StageOnResize(null);
         }
         this.FProcessorGameRoot.Visible = true;
         this.FIsUnload = true;
      }
      
      protected function ProcessorOnCopyDebugInfo(param1:Object) : void
      {
         this.FProcessorLogger.CopyDebugInfo();
      }
      
      protected function UIRootOnQuerySequenceCursor(param1:Object, param2:uint, param3:uint, param4:TQueryAnimationSequence) : void
      {
         var _loc5_:TResourceRepositoryTexture = null;
         _loc5_ = SResourcesCore.TexturesLobby;
         param4.Value = _loc5_.GetAnimationSequenceByIdentifiers(param2,param3);
      }
      
      protected function ProcessorOnGarbageCollector() : void
      {
         this.FGarbageCollector.Process(true);
      }
   }
}


package Utilities.Move
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.SLogicsCore;
   import Processors.Game.Effects.TProcessorRootEffect;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TProcessorLobby;
   import Resources.Constants.CONST_DATEBASEVO;
   import Utilities.Group.HashMap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.utils.setTimeout;
   import ghostcat.operation.RepeatOper;
   import ghostcat.operation.TweenOper;
   import ghostcat.util.easing.Cubic;
   
   public class SlowMovingAnyResource extends TProcessorLobbyWindow
   {
      
      private static var _instance:SlowMovingAnyResource;
      
      private var FRepeatOper:RepeatOper;
      
      private var FTweenOperStartFadeIn:TweenOper;
      
      private var FTweenOperStartFadeOut:TweenOper;
      
      private var _Lobby:TProcessorLobby;
      
      private var _bgMc:MovieClip;
      
      private var Btn:SimpleButton;
      
      private var Btn2:SimpleButton;
      
      private var _list:HashMap;
      
      private var _listLevel:HashMap;
      
      private var _listQuest:HashMap;
      
      private var FProcessorEffect:TProcessorRootEffect;
      
      private var runList1:Array;
      
      private var runList2:Array;
      
      private var oldLV:int;
      
      private var POINT_X:Number = 0;
      
      private var POINT_Y:Number = 0;
      
      private var TO_POINT_X:Number = 0;
      
      private var TO_POINT_Y:Number = 0;
      
      private var Desc:String = "";
      
      private var CLASS_TYPE:uint = 0;
      
      private var CLASS_NAME:String = "";
      
      private var ResourceConfig:String;
      
      private var WURL:String = "Resources/Swf/Lobby/";
      
      private var RES_SWF:String = "02000000";
      
      private var BG_SWF:uint = 33554433;
      
      private var RES_TYPE:String = ".swf";
      
      private var isRun:Boolean;
      
      public var START_TIMER:Number = 1300;
      
      public var FTweenOperStartFadeInTIMER:Number = 900;
      
      public var FTweenOperStartFadeOutTIMER:Number = 250;
      
      public var REMOVE_DISPOSE:Number = 1400;
      
      public function SlowMovingAnyResource(param1:*)
      {
         super(param1);
      }
      
      public static function getInstance(param1:* = null) : SlowMovingAnyResource
      {
         if(SlowMovingAnyResource._instance == null)
         {
            SlowMovingAnyResource._instance = new SlowMovingAnyResource(param1);
         }
         return SlowMovingAnyResource._instance;
      }
      
      public function set Lobby(param1:TProcessorLobby) : void
      {
         var _loc5_:TBins = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:TConfigValue = null;
         var _loc9_:Vector.<Object> = null;
         this._Lobby = param1;
         this.FProcessorEffect = new TProcessorRootEffect(this._Lobby);
         var _loc2_:int = 701300;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._list)
         {
            this._list.dispose();
         }
         if(this._listLevel)
         {
            this._listLevel.dispose();
         }
         if(this._listQuest)
         {
            this._listQuest.dispose();
         }
         this._list = new HashMap();
         this._listLevel = new HashMap();
         this._listQuest = new HashMap();
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         this.oldLV = SLogicsCore.Character.GetMainLevel();
         do
         {
            _loc6_ = _loc3_ > 9 ? "00" + _loc3_ : "0" + _loc3_.toString();
            _loc7_ = _loc2_ + _loc6_;
            _loc8_ = _loc5_.GetDatebaseByIdentifier(uint(_loc7_)) as TConfigValue;
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.Value as Vector.<Object>;
               this._list.addItem(_loc7_,_loc8_);
               if(_loc9_[0] == 2)
               {
                  this._listLevel.addItem(_loc9_[1],_loc8_);
               }
               if(_loc9_[0] == 1)
               {
                  this._listQuest.addItem(_loc9_[1],_loc8_);
               }
            }
            else
            {
               _loc4_++;
            }
            _loc3_++;
         }
         while(_loc4_ <= 30);
      }
      
      public function HandleQuest(param1:int) : void
      {
         if(this.runList2 == null)
         {
            this.runList2 = [];
         }
         if(this._listQuest.getItem(param1) != null)
         {
            if(this.isRun == true)
            {
               this.runList2.push(param1);
            }
            else
            {
               this.OnSetConfigVlaue(TConfigValue(this._listQuest.getItem(param1)).Value as Vector.<Object>);
            }
         }
      }
      
      public function LevelUp() : void
      {
         if(this.runList1 == null)
         {
            this.runList1 = [];
         }
         var _loc1_:* = int(SLogicsCore.Character.GetMainLevel());
         var _loc2_:* = int(_loc1_ - this.oldLV);
         if(_loc2_ == 1)
         {
            this.runList1.push(_loc1_);
            this.oldLV = SLogicsCore.Character.GetMainLevel();
         }
         else
         {
            while(_loc2_ > 0)
            {
               this.runList1.push(_loc1_);
               _loc2_--;
               _loc1_--;
            }
            this.oldLV = SLogicsCore.Character.GetMainLevel();
         }
         this.run();
      }
      
      private function run() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(Boolean(this.runList1) && this.runList1.length > 0)
         {
            _loc1_ = this.runList1.shift();
            if(this._listLevel.getItem(_loc1_) != null)
            {
               this.OnSetConfigVlaue(TConfigValue(this._listLevel.getItem(_loc1_)).Value as Vector.<Object>);
               this.isRun = true;
            }
            else
            {
               this.isRun = false;
            }
         }
         else if(Boolean(this.runList2) && this.runList2.length > 0)
         {
            _loc2_ = this.runList2.shift();
            if(this._listQuest.getItem(_loc2_) != null)
            {
               this.OnSetConfigVlaue(TConfigValue(this._listQuest.getItem(_loc2_)).Value as Vector.<Object>);
               this.isRun = true;
            }
            else
            {
               this.isRun = false;
            }
         }
         else
         {
            this.isRun = false;
         }
      }
      
      public function test() : void
      {
         var _loc1_:Array = [35,75,50,40,72];
         var _loc2_:int = int(_loc1_[int(Math.random() * _loc1_.length + 1)]);
         if(Boolean(this.isRun == false) && Boolean(this._listLevel) && Boolean(this._listLevel.getItem(_loc2_)))
         {
            this.OnSetConfigVlaue(TConfigValue(this._listLevel.getItem(_loc2_)).Value as Vector.<Object>);
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         if(this._bgMc == null)
         {
            SResourcesCore.TexturesSwfLobby.LoadPrimary(33554432);
         }
         else if(this.Btn2 == null)
         {
            SResourcesCore.TexturesSwfLobby.LoadPrimary(this.BG_SWF);
         }
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         if(this._bgMc == null)
         {
            this.OnCompleBgMcHandle();
         }
         else if(this.Btn2 == null)
         {
            this.OnCompleBtnHandle();
         }
         super.ResourcesPerform_UILocations();
      }
      
      private function OnSetConfigVlaue(param1:Vector.<Object>) : void
      {
         if(this.isRun == true)
         {
            return;
         }
         this.Desc = param1[2].toString();
         this.POINT_X = Number(param1[3]);
         this.POINT_Y = Number(param1[4]);
         this.TO_POINT_X = Number(param1[5]);
         this.TO_POINT_Y = Number(param1[6]);
         this.CLASS_TYPE = uint(param1[7]);
         this.CLASS_NAME = String(param1[8]);
         if(this._bgMc == null)
         {
            FResourcesState = RESOURCESSTATE_UIRequest;
         }
      }
      
      protected function OnCompleBgMcHandle() : void
      {
         this._bgMc = TUtilityReflection.CreateDisplayObjectInstance("MC_Unlock") as MovieClip;
         this._bgMc.mouseChildren = false;
         this._bgMc.mouseEnabled = false;
         this._bgMc.x = this.POINT_X;
         this._bgMc.y = this.POINT_Y;
         this._bgMc.TF_Desc.text = this.Desc;
         if(this.CLASS_TYPE == 1)
         {
            if(this.Btn == null)
            {
               FResourcesState = RESOURCESSTATE_UIRequest;
            }
         }
         else
         {
            this.OnCompleBtnHandle();
         }
      }
      
      protected function OnCompleBtnHandle() : void
      {
         if(this.CLASS_TYPE == 1)
         {
            if(this.Btn2 == null)
            {
               this.Btn2 = TUtilityReflection.CreateSimpleButtonByDisplayObject(this.CLASS_NAME) as SimpleButton;
            }
            this._bgMc.MC_SubstrateActivity.addChild(this.Btn2);
         }
         else
         {
            if(this.Btn == null)
            {
               this.Btn = TUtilityReflection.CreateSimpleButtonByDisplayObject(this.CLASS_NAME) as SimpleButton;
            }
            this._bgMc.MC_SubstrateActivity.addChild(this.Btn);
         }
         this._Lobby.addChild(this._bgMc);
         setTimeout(this.start,this.START_TIMER);
      }
      
      protected function start() : void
      {
         if(Boolean(this.Btn) && Boolean(this.Btn.parent))
         {
            this.Btn.parent.removeChild(this.Btn);
         }
         if(Boolean(this.Btn2) && Boolean(this.Btn2.parent))
         {
            this.Btn2.parent.removeChild(this.Btn2);
         }
         if(Boolean(this._bgMc) && Boolean(this._bgMc.parent))
         {
            this._bgMc.parent.removeChild(this._bgMc);
         }
         this._bgMc = null;
         if(this.FTweenOperStartFadeIn == null)
         {
            this.FRepeatOper = new RepeatOper();
            this.FTweenOperStartFadeIn = new TweenOper();
            this.FTweenOperStartFadeOut = new TweenOper();
            this.FTweenOperStartFadeIn.duration = this.FTweenOperStartFadeInTIMER;
            this.FTweenOperStartFadeOut.duration = this.FTweenOperStartFadeOutTIMER;
            this.FRepeatOper.loop = 1;
            this.FRepeatOper.children = [this.FTweenOperStartFadeIn,this.FTweenOperStartFadeOut];
         }
         if(this.CLASS_TYPE == 1)
         {
            this._Lobby.addChild(this.Btn2);
            this.Btn2.x = this.POINT_X + 134;
            this.Btn2.y = this.POINT_Y + 14;
            this.FTweenOperStartFadeIn.target = this.Btn2;
         }
         else
         {
            if(this.Btn == null)
            {
               this.Btn = TUtilityReflection.CreateSimpleButtonByDisplayObject(this.CLASS_NAME) as SimpleButton;
            }
            this._Lobby.addChild(this.Btn);
            this.Btn.x = this.POINT_X + 134;
            this.Btn.y = this.POINT_Y + 14;
            this.FTweenOperStartFadeIn.target = this.Btn;
         }
         this.FTweenOperStartFadeIn.params = {
            "x":this.TO_POINT_X,
            "y":this.TO_POINT_Y,
            "ease":Cubic.easeIn
         };
         this.FTweenOperStartFadeIn.execute();
         setTimeout(this.completeHandler,this.REMOVE_DISPOSE);
      }
      
      private function completeHandler(param1:Object = null) : void
      {
         if(Boolean(this.Btn) && Boolean(this.Btn.parent))
         {
            this.Btn.parent.removeChild(this.Btn);
         }
         if(this.Btn)
         {
            this.Btn = null;
         }
         this.run();
      }
   }
}

class SlowMovingAnyResourcess
{
   
   public function SlowMovingAnyResourcess()
   {
      super();
   }
}

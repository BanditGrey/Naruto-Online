package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.*;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.Coordinate.TQueryCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Agent.SParametersCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Unlocks.TUnlock;
   import Logics.Unlocks.TUnlocks;
   import Processors.Game.Common.Effects.Display.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   
   public class TWindowActiveSpecial extends TUIComponent
   {
      
      public static const POSITION_Active_Special:uint = CONST_SHORTCUTS.POSITION_Active_Special;
      
      public static const COORDINATE_ActivityBtn:Vector.<int> = Vector.<int>([1,7]);
      
      public static var ACTIVE_SPECIAL_TYPE:Vector.<uint> = CONST_SHORTCUTS.ACTIVE_SPECIAL_TYPE;
      
      public static var RESOURCE_ClassName_Active_Special_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_Active_Special_Btns;
      
      protected var FUIShortcut:TUIShortcut;
      
      protected var FUnlockStates:Vector.<Boolean>;
      
      protected var FIsInitialization:Boolean;
      
      protected var FOnActiveSpecial:Function;
      
      protected var FOnUnlockActiveSpecialResponse:Function;
      
      public function TWindowActiveSpecial(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:TAnimationSequence = null;
         var _loc6_:TConfigValue = null;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,60380123) as TConfigValue;
         if(_loc6_.Value.indexOf(SParametersCore.AgentID) >= 0)
         {
            ACTIVE_SPECIAL_TYPE.push(1);
            RESOURCE_ClassName_Active_Special_Btns.push("Shortcuts_Activity_Btn_Discord");
         }
         this.FUIShortcut = new TUIShortcut(this);
         this.FUIShortcut.Capacity = ACTIVE_SPECIAL_TYPE.length;
         this.FUIShortcut.name = "icon_conp_3";
         this.FUnlockStates = new Vector.<Boolean>(ACTIVE_SPECIAL_TYPE.length);
         this.FUIShortcut.Bmp_Left = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Left);
         this.FUIShortcut.BmpData_Middle = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Middle);
         this.FUIShortcut.Bmp_Right = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Right);
         _loc5_ = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect,0);
         this.FUIShortcut.Effects = _loc5_;
         _loc2_ = int(ACTIVE_SPECIAL_TYPE.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = RESOURCE_ClassName_Active_Special_Btns[_loc1_];
            _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject(_loc3_) as SimpleButton;
            this.FUIShortcut.SetButtonByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUnlockStates[_loc1_] = false;
            _loc1_++;
         }
      }
      
      protected function Resources_UILocations() : void
      {
         this.FUIShortcut.CoordinateBtn = COORDINATE_ActivityBtn;
         this.FUIShortcut.Perform_UIDispatch();
         this.InitializationActivitys();
      }
      
      protected function InitializationActivitys() : void
      {
         var _loc1_:uint = ACTIVE_SPECIAL_TYPE.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.FUIShortcut.SetFunctionByIndex(this.ActiveSpecialOnClick,ACTIVE_SPECIAL_TYPE[_loc2_]);
            _loc2_++;
         }
      }
      
      protected function UpdateShortcutEffect() : void
      {
         if(Boolean(this.FUIShortcut) && this.FUIShortcut.IsInitialization)
         {
            this.FUIShortcut.UpdataEffect();
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc4_:Boolean = false;
         _loc3_ = this.FUIShortcut.GetButtonByIndex(param1);
         if(!_loc3_.visible)
         {
            return;
         }
         _loc4_ = this.FUIShortcut.GetIsEffectByIndex(param1);
         if(_loc4_ != param2)
         {
            this.FUIShortcut.SetIsEffectByIndex(param2,param1);
         }
      }
      
      protected function ActiveSpecialOnClick(param1:Object, param2:int) : void
      {
         if(this.FOnActiveSpecial != null)
         {
            this.FOnActiveSpecial(this,param2);
         }
      }
      
      public function get ShortcutWidth() : int
      {
         return this.FUIShortcut.Bounds.Width;
      }
      
      public function get OnActiveSpecial() : Function
      {
         return this.FOnActiveSpecial;
      }
      
      public function set OnActiveSpecial(param1:Function) : void
      {
         this.FOnActiveSpecial = param1;
      }
      
      public function get OnUnlockActiveSpecialResponse() : Function
      {
         return this.FOnUnlockActiveSpecialResponse;
      }
      
      public function set OnUnlockActiveSpecialResponse(param1:Function) : void
      {
         this.FOnUnlockActiveSpecialResponse = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.FIsInitialization = true;
      }
      
      public function Update() : void
      {
         this.UpdateShortcutEffect();
      }
      
      public function UpdateShortcutsState(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:TUnlock = null;
         var _loc6_:SimpleButton = null;
         var _loc7_:TUnlocks = null;
         _loc7_ = param1 as TUnlocks;
         _loc3_ = _loc7_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc7_.GetUnlockByIndex(_loc2_);
            if(_loc5_.Position == POSITION_Active_Special)
            {
               _loc4_ = false;
               if(_loc5_.State == TUnlock.UNLOCKSTATE_Unlocked)
               {
                  _loc4_ = true;
                  this.FUnlockStates[_loc5_.Localtion] = _loc4_;
                  _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc5_.Localtion);
                  _loc6_.visible = _loc4_;
               }
            }
            _loc2_++;
         }
         this.UpdateActivityShortcuts();
      }
      
      protected function UpdateActivityShortcuts(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc5_:SimpleButton = null;
         var _loc6_:Boolean = false;
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc3_ = int(this.FUIShortcut.Capacity);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FUIShortcut.GetBmp_Middle(_loc2_);
            _loc5_ = this.FUIShortcut.GetButtonByIndex(_loc2_);
            _loc6_ = _loc5_.visible;
            _loc4_.visible = _loc6_;
            if(!_loc6_)
            {
               this.FUIShortcut.SetIsEffectByIndex(_loc6_,_loc2_);
            }
            _loc2_++;
         }
         this.FUIShortcut.UpdateComponentsLocation();
      }
      
      public function UnlockNotification(param1:TUnlock) : void
      {
         var _loc2_:SimpleButton = null;
         var _loc3_:TCoordinate = null;
         var _loc4_:TBounds = null;
         _loc2_ = this.FUIShortcut.GetButtonByIndex(param1.Localtion);
         _loc2_.alpha = 0;
         _loc2_.visible = true;
         this.FUnlockStates[param1.Localtion] = true;
         this.UpdateActivityShortcuts(true);
         if(this.FOnUnlockActiveSpecialResponse != null)
         {
            _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc2_);
            _loc4_ = new TBounds();
            _loc4_.Assign(_loc3_);
            _loc4_.Width = _loc2_.width;
            _loc4_.Height = _loc2_.height;
            this.FOnUnlockActiveSpecialResponse(this,_loc4_,_loc2_);
         }
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutActivityModes) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:SimpleButton = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc2_ = int(this.FUIShortcut.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.GetShortcutModeByIndex(_loc3_);
            _loc5_ = this.FUIShortcut.GetButtonByIndex(_loc3_);
            switch(_loc4_)
            {
               case TLobbyShortcutMode.SHORTCUTMODE_Show:
                  _loc6_ = true;
                  break;
               case TLobbyShortcutMode.SHORTCUTMODE_Hidden:
                  _loc6_ = false;
            }
            _loc7_ = this.FUnlockStates[_loc3_];
            if(!_loc7_)
            {
               _loc6_ = _loc7_;
            }
            _loc5_.visible = _loc6_;
            _loc3_++;
         }
         this.UpdateActivityShortcuts();
      }
      
      public function ShowEffectNotification(param1:uint, param2:Boolean) : void
      {
         this.ProcessorShortcutShowEffect(param1,param2);
      }
      
      public function QueryShortcutCoordinate(param1:Object, param2:uint, param3:TQueryCoordinate) : void
      {
         var _loc4_:SimpleButton = null;
         var _loc5_:TCoordinate = null;
         _loc4_ = this.FUIShortcut.GetButtonByIndex(param2);
         _loc5_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc4_);
         _loc5_.X += _loc4_.width / 2 - 12;
         _loc5_.Y += _loc4_.height / 2 - 6;
         param3.Value.Assign(_loc5_);
      }
   }
}


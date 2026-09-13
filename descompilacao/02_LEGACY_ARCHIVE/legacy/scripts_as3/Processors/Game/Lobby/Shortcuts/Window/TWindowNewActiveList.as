package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.ActivityMode.*;
   import Logics.NewActivity.TNewActivityModes;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TWindowNewActiveList extends TUIComponent
   {
      
      public static const POSITION_NewActiveList:uint = CONST_SHORTCUTS.POSITION_NewActiveList;
      
      public static const NEW_ACTIVELIST_TYPE:Vector.<uint> = CONST_SHORTCUTS.NEW_ACTIVELIST_TYPE;
      
      public static const RESOURCE_ClassName_NewActiveList_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_NewActiveList_Btns;
      
      protected static const COORDINATE_ActivityBtn:Vector.<int> = Vector.<int>([1,7]);
      
      protected var FWindowNewActivitySecondary:TWindowNewActivitySecondary;
      
      protected var FUIShortcut:TUIShortcut;
      
      protected var FBounds:TBounds;
      
      protected var FCoordinate:TCoordinate;
      
      protected var FIsInitialization:Boolean;
      
      protected var FNewActivityModes:TNewActivityModes;
      
      protected var FAllOpenCount:int;
      
      protected var FOnActiveList:Function;
      
      protected var FOnSecondaryActiveList:Function;
      
      public function TWindowNewActiveList(param1:TUIComponent, param2:TUIComponent)
      {
         super(param1);
         this.FWindowNewActivitySecondary = new TWindowNewActivitySecondary(param2);
         this.FWindowNewActivitySecondary.OnNewActivitySecondary = this.ActivitySecondaryOnClick;
         this.FWindowNewActivitySecondary.Visible = false;
         this.FNewActivityModes = SLogicsCore.NewActivityModes;
         this.FUIShortcut = new TUIShortcut(this);
         this.FUIShortcut.name = "icon_conp";
         this.FUIShortcut.Capacity = NEW_ACTIVELIST_TYPE.length;
         this.FBounds = new TBounds();
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:TAnimationSequence = null;
         this.FUIShortcut.Bmp_Left = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Left);
         this.FUIShortcut.BmpData_Middle = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Middle);
         this.FUIShortcut.Bmp_Right = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Right);
         _loc5_ = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect,0);
         this.FUIShortcut.Effects = _loc5_;
         _loc2_ = int(NEW_ACTIVELIST_TYPE.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = RESOURCE_ClassName_NewActiveList_Btns[_loc1_];
            _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject(_loc3_) as SimpleButton;
            if(_loc4_ == null)
            {
               _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject("Shortcuts_Activity_SubmitBug") as SimpleButton;
            }
            _loc4_.visible = false;
            this.FUIShortcut.SetButtonByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
         _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject("Shortcuts_Activity_Btn_Discord") as SimpleButton;
         this.FUIShortcut.SetButtonByIndex(_loc4_,_loc1_);
      }
      
      protected function Resources_UILocations() : void
      {
         this.FUIShortcut.CoordinateBtn = COORDINATE_ActivityBtn;
         this.FUIShortcut.Perform_UIDispatch();
         this.InitializationActivitys();
      }
      
      protected function InitializationActivitys() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(NEW_ACTIVELIST_TYPE.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUIShortcut.SetFunctionByIndex(this.ActiveListOnClick,_loc1_);
            _loc1_++;
         }
         this.FUIShortcut.OnBtnOver = this.ActivityOnOver;
         this.addEventListener(MouseEvent.ROLL_OUT,this.WindowNewActivityOnOut);
         this.FWindowNewActivitySecondary.addEventListener(MouseEvent.ROLL_OVER,this.WindowNewActivitySecondaryOnOver);
         this.FWindowNewActivitySecondary.addEventListener(MouseEvent.ROLL_OUT,this.WindowNewActivitySecondaryOnOut);
      }
      
      protected function UpdateShortcutEffect() : void
      {
         if(this.FUIShortcut.IsInitialization)
         {
            this.FUIShortcut.UpdataEffect();
         }
      }
      
      public function ProcessorOpenStatusNotification() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:SimpleButton = null;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc2_ = int(this.FUIShortcut.Capacity);
         this.FAllOpenCount = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FNewActivityModes.getActivityStatus(NEW_ACTIVELIST_TYPE[_loc1_]);
            _loc4_ = this.FUIShortcut.GetButtonByIndex(_loc1_);
            if(_loc3_)
            {
               ++this.FAllOpenCount;
            }
            if(_loc4_.visible != _loc3_)
            {
               _loc4_.visible = _loc3_;
            }
            _loc1_++;
         }
         this.UpdateActiveListShortcuts();
      }
      
      protected function UpdateActiveListShortcuts() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:Boolean = false;
         _loc2_ = int(this.FUIShortcut.Capacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIShortcut.GetBmp_Middle(_loc1_);
            _loc4_ = this.FUIShortcut.GetButtonByIndex(_loc1_);
            _loc5_ = _loc4_.visible;
            _loc3_.visible = _loc5_;
            if(!_loc5_)
            {
               this.FUIShortcut.SetIsEffectByIndex(_loc5_,_loc1_);
            }
            _loc1_++;
         }
         this.FUIShortcut.UpdateComponentsLocation();
      }
      
      protected function GetFirstShowButton() : SimpleButton
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         _loc2_ = int(this.FUIShortcut.Capacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIShortcut.GetButtonByIndex(_loc1_);
            if(_loc3_.visible)
            {
               return _loc3_;
            }
            _loc1_++;
         }
         return null;
      }
      
      protected function ComponentsAlign() : void
      {
         if(!this.Visible)
         {
            return;
         }
         var _loc1_:SimpleButton = this.FUIShortcut.GetButtonByIndex(0);
         if(!_loc1_.visible)
         {
            return;
         }
         this.FCoordinate = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc1_);
         this.FCoordinate.X += this.FUIShortcut.BmpData_Middle.width / 2;
         this.FCoordinate.Y += this.Height - 18;
         if(this.FWindowNewActivitySecondary.ShortcutWidth > 0)
         {
            this.FWindowNewActivitySecondary.X = this.FCoordinate.X - this.FWindowNewActivitySecondary.ShortcutWidth / 2;
            this.FWindowNewActivitySecondary.Y = this.FCoordinate.Y;
         }
         else if(this.FWindowNewActivitySecondary.Visible)
         {
            this.FWindowNewActivitySecondary.Hide();
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:Vector.<uint> = CONST_SHORTCUTS.NEW_ACTIVELIST_TYPE;
         var _loc7_:Vector.<uint> = CONST_SHORTCUTS.NEW_ACTIVELIST_SECONDARY_TYPE;
         _loc5_ = _loc6_.indexOf(param1);
         if(_loc5_ == -1)
         {
            this.FWindowNewActivitySecondary.ShowEffectNotification(param1,param2);
            if(param2)
            {
               _loc3_ = this.FUIShortcut.GetButtonByIndex(0);
               this.FUIShortcut.SetIsEffectByIndex(param2,0);
            }
            else if(this.FWindowNewActivitySecondary.CheckShortcutsEffect())
            {
               this.FUIShortcut.SetIsEffectByIndex(true,0);
            }
            else
            {
               this.FUIShortcut.SetIsEffectByIndex(false,0);
            }
            return;
         }
         _loc3_ = this.FUIShortcut.GetButtonByIndex(_loc5_);
         if(!_loc3_ || !_loc3_.visible)
         {
            return;
         }
         _loc4_ = this.FUIShortcut.GetIsEffectByIndex(_loc5_);
         if(_loc4_ != param2)
         {
            this.FUIShortcut.SetIsEffectByIndex(param2,_loc5_);
         }
      }
      
      protected function ActiveListOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:Boolean = false;
         if(param2 == 0)
         {
            _loc3_ = this.FWindowNewActivitySecondary.Visible;
            if(!_loc3_)
            {
               this.FWindowNewActivitySecondary.Hide();
            }
            else
            {
               this.FWindowNewActivitySecondary.Show();
            }
            return;
         }
         if(this.FOnActiveList != null)
         {
            this.FOnActiveList(this,param2);
         }
      }
      
      protected function ActivitySecondaryOnClick(param1:Object, param2:int) : void
      {
         if(this.FOnSecondaryActiveList != null)
         {
            this.FOnSecondaryActiveList(this,param2);
         }
      }
      
      protected function ActivityOnOver(param1:Object, param2:int) : void
      {
         if(param2 == 0)
         {
            this.FWindowNewActivitySecondary.Show();
            return;
         }
         this.FWindowNewActivitySecondary.Hide();
      }
      
      protected function WindowNewActivityOnOut(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:TCoordinate = null;
         _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(this.FWindowNewActivitySecondary);
         this.FBounds.Assign(_loc3_);
         this.FBounds.Width = this.FWindowNewActivitySecondary.ShortcutWidth;
         this.FBounds.Height = this.FWindowNewActivitySecondary.Height + 20;
         this.FBounds.Y -= 20;
         _loc2_ = TUtilityCartisian.BoundsContainsCoordinate(this.FBounds,FUICore.MouseCoordinate);
         if(!_loc2_)
         {
            this.FWindowNewActivitySecondary.Hide();
         }
      }
      
      protected function WindowNewActivitySecondaryOnOver(param1:MouseEvent) : void
      {
         this.FWindowNewActivitySecondary.Show();
      }
      
      protected function WindowNewActivitySecondaryOnOut(param1:MouseEvent) : void
      {
         this.FWindowNewActivitySecondary.Hide();
      }
      
      public function get ShortcutWidth() : int
      {
         return this.FUIShortcut.Bounds.Width;
      }
      
      public function get OnActiveList() : Function
      {
         return this.FOnActiveList;
      }
      
      public function set OnActiveList(param1:Function) : void
      {
         this.FOnActiveList = param1;
      }
      
      public function get AllOpenCount() : int
      {
         return this.FAllOpenCount;
      }
      
      public function set AllOpenCount(param1:int) : void
      {
         this.FAllOpenCount = param1;
      }
      
      public function get OnSecondaryActiveList() : Function
      {
         return this.FOnSecondaryActiveList;
      }
      
      public function set OnSecondaryActiveList(param1:Function) : void
      {
         this.FOnSecondaryActiveList = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.FWindowNewActivitySecondary.Perform_UIDispatch();
         this.FIsInitialization = true;
      }
      
      public function Update() : void
      {
         this.ComponentsAlign();
         this.FWindowNewActivitySecondary.Update();
         this.UpdateShortcutEffect();
      }
      
      public function OpenStatusNotification() : void
      {
         this.ProcessorOpenStatusNotification();
      }
      
      public function ShowEffectNotification(param1:uint, param2:uint, param3:Boolean) : void
      {
         switch(param1)
         {
            case POSITION_NewActiveList:
               this.ProcessorShortcutShowEffect(param2,param3);
         }
      }
      
      public function UpdateShortcutsState(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:SimpleButton = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         this.FWindowNewActivitySecondary.UpdateShortcutsState(null,null,0);
         this.UpdateActivityShortcuts();
      }
      
      protected function UpdateActivityShortcuts(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc5_:SimpleButton = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
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
            _loc7_ = _loc5_.visible;
            _loc4_.visible = _loc7_;
            _loc2_++;
         }
         this.FUIShortcut.UpdateComponentsLocation();
      }
   }
}


"""
pythonedaartifacteventinfrastructuregittagging/pythonedaartifacteventgittaggingdbus/dbus_tag_credentials_requested.py

This file defines the DbusTagCredentialsRequested class.

Copyright (C) 2023-today rydnr's pythoneda-artifact-eventinfrastructure/git-tagging

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""

from dbus_next.service import ServiceInterface, method, signal
from dbus_next import Variant

class DbusTagCredentialsRequested(ServiceInterface):
    """
    D-Bus interface for TagCredentialsRequested

    Class name: DbusTagCredentialsRequested

    Responsibilities:
        - Define the d-bus interface for the TagCredentialsRequested event.

    Collaborators:
        - None
    """
    def __init__(self):
        """
        Creates a new DbusTagCredentialsRequested.
        """
        super().__init__('pythonedaartifactgittagging.TagCredentialsRequested')

    @signal()
    def TagCredentialsRequested(self, message: 's'):
        """
        Defines the TagCredentialsRequested d-bus signal.
        :param message: A message.
        :type message: str
        """
        pass

    @classmethod
    def path(cls) -> str:
        """
        Retrieves the d-bus path.
        :return: Such value.
        :rtype: str
        """
        return "/pythoneda/artifact/git_tagging"
